//
//  MovieDetailView.swift
//  Megabox
//
//  Created by 권예원 on 10/6/25.
//

import SwiftUI

struct MovieDetailView: View {
    @Bindable var viewModel: HomeViewModel
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false){
            LazyVStack() {
                Image(.f1StillCut)
                    .padding(.bottom, 9)
                movieInfo
                    .padding(.bottom, 30)
                bottomSegment
                if selected == .detailInfo{
                    detailInfo
                } else if selected == .reviews{
                    reviews
                }
            }
            .navigationTitle(viewModel.selectedMovie?.movieName ?? "영화제목")
        }
        
    }
    
    private var movieInfo: some View {
        VStack(spacing:0){
            Text(viewModel.selectedMovie?.movieName ?? "영화제목")
                .font(.PretendardSemiBold24)
                .foregroundStyle(.black)
            Text(viewModel.selectedMovie?.movieName_Eng ?? "movieName_Eng")
                .font(.PretendardSemiBold14)
                .foregroundStyle(.gray03)
                .frame(minHeight: 20)
                .padding(.bottom, 9)
            Text("""
            최고가 되지 못한 전설 VS 최고가 되고 싶은 루키

            한때 주목받는 유망주였지만 끔찍한 사고로 F1에서 우승하지 못하고
            한순간에 추락한 드라이버 ‘손 헤이스’(브래드 피트).
            그의 오랜 동료인 ‘루벤 세르반테스’(하비에르 바르뎀)에게
            레이싱 복귀를 제안받으며 최하위 팀인 APXGP에 합류한다.
            """)
            .font(.PretendardSemiBold18)
            .foregroundStyle(.gray03)
        }
        .padding(.horizontal, 15)
    }
    
    enum Section: String, CaseIterable {
        case detailInfo = "상세정보"
        case reviews = "실관람평"
    }
    
    @State private var selected:Section = .detailInfo
    
    private var bottomSegment: some View {
        HStack(spacing: 0) {
            ForEach(Section.allCases, id: \.self) { section in
                
                    Button(action:{
                        selected = section
                    }, label: {
                        VStack{
                            Text(section.rawValue)
                                .font(.PretendardBold22)
                            Rectangle()
                                .frame(height:2)
                        }
                        .foregroundStyle(selected == section ? .black : .gray02)
                        .frame(height: 35)
                    })
                    

            }
        }

    }
    
    private var detailInfo: some View {
        HStack(spacing:0){
            Image(.f1DetailPoster)
            VStack(alignment: .leading, spacing: 9 ){
                Text("12세  이상 관람가")
                Text("2025.06.25 개봉")
                Spacer()
            }
            .font(.PretendardSemiBold13)
            .foregroundStyle(.black)
            .frame(width: 114)
            Spacer()
        }.padding(15)

    }
    
    private var reviews: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10)
                .stroke(.purple02, lineWidth: 1)
            Text("등록된 관람평이 없어요 🥲")
                .font(.PretendardSemiBold18)
                .foregroundStyle(.gray08)
                .lineLimit(1)
                .padding(.vertical, 60)
        }
        .padding(15)
    }

}

struct MovieDetailView_Preview: PreviewProvider {
    static var devices = ["iPhone 11", "iPhone 16 Pro Max"]
    
    static var previews: some View {
        ForEach(devices, id: \.self) { device in
            MovieDetailView(viewModel:HomeViewModel())
                .previewDevice(PreviewDevice(rawValue: device))
                .previewDisplayName(device)
        }
    }
}

