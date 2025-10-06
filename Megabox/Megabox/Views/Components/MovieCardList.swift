//
//  MovieCardList.swift
//  Megabox
//
//  Created by 권예원 on 10/6/25.
//

import SwiftUI

struct MovieCardList: View {
    let movies: [MovieModel]
    let isUpcoming: Bool

    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            LazyHStack(spacing: 24) {
                ForEach(movies) { movie in
                    VStack(spacing: 0) {
                        movie.movieImage
                            .resizable()
                            .frame(width: 148, height: 212)

                        if isUpcoming {
                            Spacer().frame(height: 16)
                        } else {
                            Button("바로예매") {}
                                .font(.PretendardMedium16)
                                .foregroundStyle(.purple03)
                                .frame(width: 148, height: 36)
                                .background {
                                    RoundedRectangle(cornerRadius: 10)
                                        .stroke(.purple03, lineWidth: 1)
                                        .fill(Color.clear)
                                }
                                .padding(.vertical, 8)
                        }

                        Text(movie.movieName)
                            .font(.PretendardBold22)
                            .foregroundStyle(.black)
                            .frame(width: 149, alignment: .leading)
                            .lineLimit(1)
                            .truncationMode(.tail)

                        Spacer().frame(height: 3)

                        Text(isUpcoming ? "상영예정" : "누적관객수 \(movie.movieViewers)")
                            .font(.PretendardMedium18)
                            .frame(width: 148, alignment: .leading)
                    }
                }
            }
        }
    }
}

#Preview {
    MovieCardList(movies: HomeViewModel().movies, isUpcoming: true)
}
