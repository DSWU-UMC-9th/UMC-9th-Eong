//
//  BookingViewModel.swift
//  Megabox
//
//  Created by 권예원 on 10/11/25.
//

import SwiftUI
import Foundation
import Combine


class BookingViewModel: ObservableObject {
    @Published var isLoading:Bool = false
    @Published var errorMessage:String? = nil
    
    @Published var movies:[Movie] = []
    @Published var theaters:[Theater] = []
    @Published var rooms:[Room] = []
    @Published var shows:[Show] = []
    
    @Published var selectedMovie:Movie?
    @Published var selectedTheater:[Theater] = []
    @Published var selectedRoom:Room?
    @Published var selectedShow:Show?
    
    
    @Published var isTheaterSectionVisible = false
    @Published var isDayBarVisible: Bool = false
    @Published var isShowCardsVisible: Bool = false
    
    @Published var days: [DayItem] = []
    @Published var selectedDate: Date = Calendar.current.startOfDay(for: Date())
    
    private var bag = Set<AnyCancellable>()
    
    private static let seoul = TimeZone(identifier: "Asia/Seoul")!

    
    init(){
        $selectedMovie
            .map { $0 != nil }
            .removeDuplicates()
            .assign(to: &$isTheaterSectionVisible)
        $selectedTheater
            .map { !$0.isEmpty }              
            .removeDuplicates()
            .assign(to: &$isDayBarVisible)
        
        $isDayBarVisible
            .removeDuplicates()
            .sink { [weak self] on in
                guard let self else { return }
                if on {
                    if self.days.isEmpty { self.generateDays(start: self.selectedDate) }
                    if let first = self.days.first {
                        var cal = Calendar.current; cal.timeZone = Self.seoul
                        if !self.days.contains(where: { cal.isDate($0.date, inSameDayAs: self.selectedDate) }) {
                            self.selectedDate = first.date
                        }
                    }
                }
                self.isShowCardsVisible = on
            }
            .store(in: &bag)
        
    }
    
    @MainActor
    func fetchMovieSchedule() async {
        print("📁 파일 경로:", Bundle.main.url(forResource: "MovieSchedule", withExtension: "json") ?? "없음")

        isLoading = true
        
        guard let url = Bundle.main.url(
            forResource: "MovieSchedule", withExtension: "json") else {
            errorMessage = "MovieSchedule.json 파일이 없습니다."
            return }
        guard let data = try? Data(contentsOf: url) else {
            errorMessage = "MovieSchedule.json을 불러오는 중 오류가 발생했습니다."
            return }

        do {
            let response = try JSONDecoder().decode(APIResponse.self, from: data)
            print("🎞️ 디코딩된 영화 수:", response.data.movies.count)
            
            var allMovies: [Movie] = []
            var allTheaters: [Theater] = []
            var allRooms: [Room] = []
            var allShows: [Show] = []
            
            for movieDTO in response.data.movies {
                let (movie, theaters, rooms, shows) = MovieMapper.toDomain(from: movieDTO)
                allMovies.append(movie)
                allTheaters.append(contentsOf: theaters)
                allRooms.append(contentsOf: rooms)
                allShows.append(contentsOf: shows)
            }
            
            let uniqueTheaters = Array(Set(allTheaters))

            self.movies = allMovies
            self.theaters = uniqueTheaters
            self.rooms = allRooms
            self.shows = allShows
            self.isLoading = false

        } catch {
            print("Decoding error:", error)
            errorMessage = "데이터를 불러오는 중 문제가 발생했습니다."
        }
    }
    
    // 극장 선택
    func isSelectedTheater(_ theater: Theater) -> Bool {
        selectedTheater.contains(where: { $0.id == theater.id })
    }
    func toggle(_ theater: Theater) {
        if let i = selectedTheater.firstIndex(where: { $0.id == theater.id }) {
            selectedTheater.remove(at: i)
        } else {
            selectedTheater.append(theater)
        }
    }

    // 오늘 기준 7일 생성
    func generateDays(start: Date = Date()) {
        var cal = Calendar.current
        cal.timeZone = Self.seoul
        let s = cal.startOfDay(for: start)
        days = (0..<7).compactMap { off in
            guard let d = cal.date(byAdding: .day, value: off, to: s) else { return nil }
            let dayNum = cal.component(.day, from: d)
            return DayItem(day: dayNum, date: d,
                           isCurrentMonth: cal.isDate(d, equalTo: s, toGranularity: .month))
        }
    }
    
    // 날짜 선택
    func selectDay(_ item: DayItem) {
        selectedDate = item.date
        
    }
    func isSelectedDay(_ item: DayItem) -> Bool {
        Calendar.current.isDate(selectedDate, inSameDayAs: item.date)
    }


    private var moviesById: [String: Movie] {
        Dictionary(uniqueKeysWithValues: movies.map { ($0.id, $0) })
    }
    private var theatersById: [String: Theater] {
        Dictionary(uniqueKeysWithValues: theaters.map { ($0.id, $0) })
    }
    private var roomsById: [String: Room] {
        Dictionary(uniqueKeysWithValues: rooms.map { ($0.id, $0) })
    }
    
    typealias RoomGroup = (room: Room, shows: [Show])
    typealias TheaterGroup = (theater: Theater, rooms: [RoomGroup])
    
    var groupedShows: [TheaterGroup] {
            guard let selectedMovie, !selectedTheater.isEmpty else { return [] }

            var cal = Calendar.current;
            cal.timeZone = Self.seoul

            let filtered = shows.filter { s in
                s.movieId == selectedMovie.id &&
                selectedTheater.contains(where: { $0.id == s.theaterId }) &&
                cal.isDate(s.startAt, inSameDayAs: selectedDate)
            }

            let sorted = filtered.sorted { $0.startAt < $1.startAt }

            let byTheater = Dictionary(grouping: sorted, by: { $0.theaterId })

            return byTheater.compactMap { (theaterId, showsInTheater) -> TheaterGroup? in
                guard let theater = theatersById[theaterId] else { return nil }
                let byRoom = Dictionary(grouping: showsInTheater, by: { $0.roomId })
                let roomsTuple: [RoomGroup] = byRoom.compactMap { (roomId, showsInRoom) -> RoomGroup? in
                    guard let room = roomsById[roomId] else { return nil }
                    return (room: room, shows: showsInRoom)
                }
                .sorted { $0.room.name < $1.room.name }
                return (theater: theater, rooms: roomsTuple)
            }
            .sorted { $0.theater.name < $1.theater.name }
        }
    
    func endTime(of show: Show) -> Date {
        var cal = Calendar.current;
        cal.timeZone = Self.seoul
        let runTime = moviesById[show.movieId]?.runningTime ?? 0
        return cal.date(byAdding: .minute, value: runTime, to: show.startAt)!
    }

}


