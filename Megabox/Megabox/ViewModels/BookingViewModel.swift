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
    @Published var movies:[Movie]
    @Published var theaters:[Theater]
    @Published var rooms:[Room]
    @Published var shows:[Show]
    
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
        let movies:[Movie] = [
            .init(title: "F1 더 무비",grade: "15", poster: .init(.posterF1), runningTime: 148),
            .init(title: "극장판 귀멸의 칼날: 무한성편",grade: "15", poster: .init(.posterDemonSlayer),runningTime: 148),
            .init(title: "어쩔수가없다", grade: "15",poster: .init(.posterNoOtherChoic),runningTime: 148),
            .init(title: "얼굴", grade: "15",poster: .init(.posterFace),runningTime: 148),
            .init(title: "모노노케 히메", grade: "15",poster: .init(.posterPrincessMononoke),runningTime: 148),
            .init(title: "보스", grade: "15",poster: .init(.posterBoss),runningTime: 148),
            .init(title: "완벽한 이혼",grade: "15", poster: .init(.posterTheRose),runningTime: 148),
            .init(title: "야당", grade: "15",poster: .init(.posterYadang),runningTime: 148)
        ]
        let theaters:[Theater] = [
            .init(name: "강남"),
            .init(name: "홍대"),
            .init(name: "신촌")
        ]
        
        let rooms:[Room] = [
            .init(theaterId: theaters[0].id, name: "크리클라이너 1관"),
            .init(theaterId: theaters[1].id, name: "BTS관 (7층 1관 [Laser])"),
            .init(theaterId: theaters[1].id, name: "BTS관 (9층 2관 [Laser])")
        ]
        

        let shows:[Show] = [
            // 강남
            .init(
                movieId: movies[0].id,
                theaterId: theaters[0].id,
                roomId: rooms[0].id,
                startAt: BookingViewModel.makeDate(year: 2025, month: 10, day: 13, hour: 11, minute: 30),
                totalSeats: 116,
                bookedSeats: 7
            ),
            .init(
                movieId: movies[0].id,
                theaterId: theaters[0].id,
                roomId: rooms[0].id,
                startAt: BookingViewModel.makeDate(year: 2025, month: 10, day: 13, hour: 14, minute: 20),
                totalSeats: 116,
                bookedSeats: 97
            ),
            .init(
                movieId: movies[0].id,
                theaterId: theaters[0].id,
                roomId: rooms[0].id,
                startAt: BookingViewModel.makeDate(year: 2025, month: 10, day: 13, hour: 17, minute: 05),
                totalSeats: 116,
                bookedSeats: 115
            ),
            .init(
                movieId: movies[0].id,
                theaterId: theaters[0].id,
                roomId: rooms[0].id,
                startAt: BookingViewModel.makeDate(year: 2025, month: 10, day: 13, hour: 19, minute: 45),
                totalSeats: 116,
                bookedSeats: 16
            ),
            .init(
                movieId: movies[0].id,
                theaterId: theaters[0].id,
                roomId: rooms[0].id,
                startAt: BookingViewModel.makeDate(year: 2025, month: 10, day: 13, hour: 22, minute: 20),
                totalSeats: 116,
                bookedSeats: 0
            ),
            
            // 홍대 - 1
            .init(
                movieId: movies[0].id,
                theaterId: theaters[1].id,
                roomId: rooms[1].id,
                startAt: BookingViewModel.makeDate(year: 2025, month: 10, day: 13, hour: 9, minute: 30),
                totalSeats: 116,
                bookedSeats: 41
            ),
            .init(
                movieId: movies[0].id,
                theaterId: theaters[1].id,
                roomId: rooms[1].id,
                startAt: BookingViewModel.makeDate(year: 2025, month: 10, day: 13, hour: 12, minute: 00),
                totalSeats: 116,
                bookedSeats: 14
            ),
            .init(
                movieId: movies[0].id,
                theaterId: theaters[1].id,
                roomId: rooms[1].id,
                startAt: BookingViewModel.makeDate(year: 2025, month: 10, day: 13, hour: 14, minute: 45),
                totalSeats: 116,
                bookedSeats: 28
            ),
            
            //홍대 - 2
            .init(
                movieId: movies[0].id,
                theaterId: theaters[1].id,
                roomId: rooms[2].id,
                startAt: BookingViewModel.makeDate(year: 2025, month: 10, day: 13, hour: 11, minute: 30),
                totalSeats: 116,
                bookedSeats:82
            ),
            .init(
                movieId: movies[0].id,
                theaterId: theaters[1].id,
                roomId: rooms[2].id,
                startAt: BookingViewModel.makeDate(year: 2025, month: 10, day: 13, hour: 14, minute: 10),
                totalSeats: 116,
                bookedSeats: 16
            ),
            .init(
                movieId: movies[0].id,
                theaterId: theaters[1].id,
                roomId: rooms[2].id,
                startAt: BookingViewModel.makeDate(year: 2025, month: 10, day: 13, hour: 11, minute: 30),
                totalSeats: 116,
                bookedSeats: 103
            ),
            .init(
                movieId: movies[0].id,
                theaterId: theaters[1].id,
                roomId: rooms[2].id,
                startAt: BookingViewModel.makeDate(year: 2025, month: 10, day: 13, hour: 11, minute: 30),
                totalSeats: 116,
                bookedSeats: 24
            )
            
        ]
        
        self.movies = movies
        self.theaters = theaters
        self.rooms = rooms
        self.shows = shows
        
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
                self.isShowCardsVisible = on     // ✅ DayBar와 동기화
            }
            .store(in: &bag)
        
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


    // date 값 생성 : 년, 월, 일, 시, 분
    private static func makeDate(year: Int, month: Int, day: Int, hour: Int, minute: Int) -> Date {
        var cal = Calendar.current
        cal.timeZone = seoul
        var comp = DateComponents()
        comp.timeZone = seoul
        comp.year = year
        comp.month = month
        comp.day = day
        comp.hour = hour
        comp.minute = minute
        comp.second = 0
        return cal.date(from: comp)!
    }

    private var moviesById: [UUID: Movie] {
        Dictionary(uniqueKeysWithValues: movies.map { ($0.id, $0) })
    }
    private var theatersById: [UUID: Theater] {
        Dictionary(uniqueKeysWithValues: theaters.map { ($0.id, $0) })
    }
    private var roomsById: [UUID: Room] {
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


