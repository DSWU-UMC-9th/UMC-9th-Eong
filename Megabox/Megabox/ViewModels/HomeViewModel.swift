//
//  MovieViewModel.swift
//  Megabox
//
//  Created by 권예원 on 10/5/25.
//

import SwiftUI
import Foundation

@Observable
class HomeViewModel {
    let movies: [MovieModel] = [
        .init(movieImage: .init(.posterNoOtherChoic), movieName: "어쩔수가없다", movieName_Eng: "No Other Choice", movieViewers: "20만"),
        .init(movieImage: .init(.posterDemonSlayer), movieName: "극장판 귀멸의 칼날: 무한성편", movieName_Eng: "Demon Slayer: Kimetsu no Yaiba – The Movie: Infinity Castle", movieViewers: "1"),
        .init(movieImage: .init(.posterF1), movieName: "F1 더 무비",movieName_Eng: "F1 : The Movie", movieViewers: "20만"),
        .init(movieImage: .init(.posterFace), movieName: "얼굴",movieName_Eng: "The Ugly", movieViewers: "20만"),
        .init(movieImage: .init(.posterPrincessMononoke), movieName: "모노노케 히메",movieName_Eng: "Princess Mononoke", movieViewers: "20만")
    ]
    
    var selectedMovie: MovieModel?
    
    // 임시
    let upcomings: [MovieModel] = [
        .init(movieImage: .init(.posterPrincessMononoke), movieName: "모노노케 히메", movieName_Eng: "Princess Mononoke",movieViewers: "20만"),
        .init(movieImage: .init(.posterFace), movieName: "얼굴",movieName_Eng: "The Ugly", movieViewers: "20만"),
        .init(movieImage: .init(.posterF1), movieName: "F1 더 무비",movieName_Eng: "F1 : The Movie", movieViewers: "20만"),
        .init(movieImage: .init(.posterDemonSlayer), movieName: "극장판 귀멸의 칼날: 무한성편",movieName_Eng: "Demon Slayer: Kimetsu no Yaiba – The Movie: Infinity Castle", movieViewers: "1"),
        .init(movieImage: .init(.posterNoOtherChoic), movieName: "어쩔수가없다",movieName_Eng: "No Other Choice", movieViewers: "20만")
    ]
    
    let feeds: [FeedModel] = [
        .init(feedImage: .init(.thumbnail01), feedTitle: "9월, 메가박스의 영화들(1) - 명작들의 재개봉’", feedTag: "<모노노케 히메>,<퍼펙트 블루>"),
        .init(feedImage: .init(.thumbnail02), feedTitle: "메가박스 오리지널 티켓 Re.37 <얼굴>", feedTag: "영화 속 양극적인 감정의 대비")
    ]
}

