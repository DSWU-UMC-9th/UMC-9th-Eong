//
//  MovieBookingView.swift
//  Megabox
//
//  Created by 권예원 on 10/11/25.
//

import SwiftUI

struct MovieBookingView: View {
    @ObservedObject var viewModel: BookingViewModel
    
    var body: some View {
        NavigationStack{
            ScrollView{
                LazyVStack(spacing:0) {
                    selectMovie
                        .padding(.bottom, 32)
                    if viewModel.isTheaterSectionVisible {
                        theaterList
                            .padding(.bottom, 29)
                    } else {
                        Spacer().frame(height: 29)
                    }
                    
                    if viewModel.isDayBarVisible {
                        dayBar
                            .padding(.bottom, 49)
                    } else {
                        Spacer()
                    }
                    if viewModel.isShowCardsVisible {
                        showList
                            .padding(.vertical, 8)
                    } else {
                        Spacer().frame(height: 8)
                    }
                    
                }.padding(.horizontal,16)
            }
            .safeAreaInset(edge: .top, alignment: .center, spacing: nil) {
                Text("영화별 예매")
                    .font(.PretendardBold22)
                    .foregroundStyle(.white)
                    .padding(.top, 41)
                    .padding(.bottom, 10)
                    .frame(maxWidth: .infinity)
                    .background(.purple03)
            }
        }

    }

    
    private var selectMovie: some View {
        VStack(spacing: 20){
            HStack(){
                if viewModel.selectedMovie == nil {
                    Spacer()
                }
                if let selectedMovie = viewModel.selectedMovie {
                    ZStack{
                        RoundedRectangle(cornerRadius: 4)
                            .foregroundStyle(.etcOrangeTag)
                            .frame(width: 26, height: 24)
                        Text(selectedMovie.grade)
                            .font(.PretendardBold18)
                            .foregroundStyle(.white)
                    }
                    Spacer().frame(width:37)
                    Text(selectedMovie.title)
                        .frame(width:238, height: 24)
                        .font(.PretendardBold18)
                        .foregroundStyle(.black)
                    Spacer()
                }
                Button(action: {
                    
                }, label: {
                    Text("전체영화")
                        .font(.PretendardSemiBold14)
                        .foregroundStyle(.black)
                        .padding(10)
                        .background(
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(.gray02, lineWidth: 1)
                        )
                })
            }
            
            ScrollView(.horizontal, showsIndicators: false){
                LazyHStack(spacing:8){
                    ForEach(viewModel.movies) { movie in
                        movie.poster
                            .resizable()
                            .frame(width: 62, height: 89)
                            .clipShape(RoundedRectangle(cornerRadius: 4))
                            .overlay(
                                RoundedRectangle(cornerRadius: 4)
                                    .stroke(viewModel.selectedMovie?.id == movie.id ? .purple03 : .clear, lineWidth:2)
                            )
                            .onTapGesture {
                                if viewModel.selectedMovie?.id == movie.id {
                                    viewModel.selectedMovie = nil
                                } else {
                                    viewModel.selectedMovie = movie
                                }
                            }
                    }
                }
            }
        }
        
    }
    
    private var theaterList: some View {
        HStack(spacing: 8){
            ForEach(viewModel.theaters) { theater in
                            let selected = viewModel.isSelectedTheater(theater)
                            Button {
                                viewModel.toggle(theater)
                            } label: {
                                Text(theater.name)
                                    .font(.PretendardSemiBold16)
                                    .foregroundStyle(selected ? .white : .gray05)
                                    .padding(.vertical, 8)
                                    .padding(.horizontal, 12)
                                    .background(
                                        RoundedRectangle(cornerRadius: 15)
                                            .fill(selected ? Color.purple03 : Color.gray01)
                                    )
                            }
                        }
            Spacer()
        }
    }
    
    private var dayBar: some View {
        ScrollView(.horizontal, showsIndicators: false){
            HStack(spacing: 5){
                ForEach(Array(viewModel.days.enumerated()), id: \.element.id) { index, item in
                    let cal = Calendar.current
                    let isFirstOfMonth = cal.component(.day, from: item.date) == 1
                    let showMonthDotDay = (index == 0) || isFirstOfMonth
                    let selected = viewModel.isSelectedDay(item)
                    Button (action:{
                        viewModel.selectDay(item)
                    }, label: {
                        VStack(spacing: 4) {

                            Text(isFirstOfMonth || showMonthDotDay ? "\(Calendar.current.component(.month, from: item.date)).\(item.day)" : "\(item.day)")
                                .font(.PretendardBold18)
                                .foregroundStyle(selected ? .white : weekdayColor(for: item.date))
                            
                            Text(weekdayLabel(for: item.date))
                                .font(.PretendardSemiBold14)
                                .foregroundStyle(selected ? .white : .gray03)
                        }

                    })
                    .frame(width: 55, height: 60)
                    .background(
                        RoundedRectangle(cornerRadius: 12)
                            .fill(selected ? .purple03 : .clear)
                    )
                }
            }
        }
    }
    private func weekdayLabel(for date: Date) -> String {
        let cal = Calendar.current
        if cal.isDateInToday(date) { return "오늘" }
        if cal.isDateInTomorrow(date) { return "내일" }
        let syms = ["일","월","화","수","목","금","토"]
        return syms[cal.component(.weekday, from: date) - 1]
    }

    private func weekdayColor(for date: Date) -> Color {
        let wd = Calendar.current.component(.weekday, from: date)
        switch wd {
        case 1: return .etcHoliday
        case 7: return .etcTag
        default: return .secondary
        }
    }
    
    private var showList: some View {
        VStack(alignment:.leading){
            if viewModel.groupedShows.isEmpty {
                Text("해당 날짜에 상영 정보가 없습니다.")
                    .font(.PretendardSemiBold14)
                    .foregroundStyle(.gray03)
            } else {
                ForEach(viewModel.selectedTheater.sorted(by: { $0.name < $1.name })) { theater in
                    // 극장 헤더
                    Text(theater.name)
                        .font(.PretendardBold18)
                        .foregroundStyle(.black)
                        .padding(.bottom, 21)
                    
                    // 이 극장에 해당 날짜/영화로 필터된 방 목록 (없으면 빈 배열)
                    let rooms = viewModel.groupedShows.first { $0.theater.id == theater.id }?.rooms ?? []
                    
                    // 방이 없으면 안내문
                    if rooms.isEmpty {
                        Text("해당 극장에 상영 정보가 없습니다.")
                            .font(.PretendardSemiBold14)
                            .foregroundStyle(.gray03)
                            .padding(.bottom, 29)
                    }
                    
                    // 방 섹션
                    ForEach(rooms, id: \.room.id) { r in
                        HStack {
                            Text(r.room.name)
                                .font(.PretendardBold18)
                                .foregroundStyle(.black)
                            Spacer()
                            Text("2D")
                                .font(.PretendardSemiBold14)
                                .foregroundStyle(.black)
                        }
                        .padding(.bottom, 21)
                        
                        var columns: [GridItem] { Array(repeating: GridItem(.flexible(),alignment: .top), count:4) }
                        
                        LazyVGrid(columns: columns, alignment: .leading, spacing: 19) {
                            ForEach(r.shows) { show in
                                ShowCard(show: show)
                                    .environmentObject(viewModel)
                            }
                        }
                        .padding(.bottom, 29)
                        .padding(.horizontal, -16) }
                }
            }
        }
    }
}

// 미리보기
struct MovieBookingView_Preview: PreviewProvider {
    static var devices = ["iPhone 11", "iPhone 16 Pro Max"]
    
    static var previews: some View {
        ForEach(devices, id: \.self) { device in
            MovieBookingView(viewModel: BookingViewModel())
                .environment(Router())
                .previewDevice(PreviewDevice(rawValue: device))
                .previewDisplayName(device)
        }
    }
}
