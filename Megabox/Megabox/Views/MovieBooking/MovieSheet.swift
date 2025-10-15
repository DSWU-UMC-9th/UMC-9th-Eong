//
//  MovieSheet.swift
//  Megabox
//
//  Created by 권예원 on 10/13/25.
//

import SwiftUI

struct MovieSheet: View {
    @ObservedObject var viewModel:MovieSheetViewModel
    var onTab: (Movie) -> Void
    
    var body: some View {
        NavigationStack{
            var columns: [GridItem] {
                Array(repeating: GridItem(.flexible(), alignment: .top), count: 3)
            }
                
            VStack(spacing:36){
                LazyVGrid(columns:columns,spacing:36){
                    ForEach(viewModel.query.isEmpty ? viewModel.movies : viewModel.results){ movie in
                        VStack(spacing:8){
                            movie.poster
                                .resizable()
                                .frame(width:95, height: 135)
                            Text(movie.title)
                                .font(.PretendardSemiBold14)
                                .foregroundStyle(.black)
                        }.onTapGesture {
                            onTab(movie)
                        }
                    }
                }
                Spacer()
            }
        }
        .overlay(alignment: .top) {
            Text("영화별 예매")
                .font(.PretendardBold18)
                .foregroundStyle(.black)
                .padding(.top, 16) // 상태바와 약간의 간격
        }
        .searchable(text: $viewModel.query, prompt: "영화명을 입력해주세요")
        .searchPresentationToolbarBehavior(.avoidHidingContent)
    }
}

#Preview {
    let sampleMovies: [Movie] = [
        .init(title: "F1 더 무비", grade: "15", poster: .init(.posterF1), runningTime: 148),
        .init(title: "극장판 귀멸의 칼날: 무한성편", grade: "15", poster: .init(.posterDemonSlayer), runningTime: 148),
        .init(title: "어쩔수가없다", grade: "15", poster: .init(.posterNoOtherChoic), runningTime: 148)
    ]
    MovieSheet(
        viewModel: MovieSheetViewModel(movies: sampleMovies),
        onTab: { movie in
            print("선택한 영화: \(movie.title)")
        }
    )
}
