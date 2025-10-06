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
        .init(movieImage: .init(.posterNoOtherChoic), movieName: "어쩔수가없다", movieViewers: "20만"),
        .init(movieImage: .init(.posterDemonSlayer), movieName: "극장판 귀멸의 칼날: 무한성편", movieViewers: "1"),
        .init(movieImage: .init(.posterF1), movieName: "F1 더 무비", movieViewers: "20만"),
        .init(movieImage: .init(.posterFace), movieName: "얼굴", movieViewers: "20만"),
        .init(movieImage: .init(.posterPrincessMononoke), movieName: "모노노케 히메", movieViewers: "20만")
    ]
    
    // 임시 
    let upcomings: [MovieModel] = [
        .init(movieImage: .init(.posterPrincessMononoke), movieName: "모노노케 히메", movieViewers: "20만"),
        .init(movieImage: .init(.posterFace), movieName: "얼굴", movieViewers: "20만"),
        .init(movieImage: .init(.posterF1), movieName: "F1 더 무비", movieViewers: "20만"),
        .init(movieImage: .init(.posterDemonSlayer), movieName: "극장판 귀멸의 칼날: 무한성편", movieViewers: "1"),
        .init(movieImage: .init(.posterNoOtherChoic), movieName: "어쩔수가없다", movieViewers: "20만")
    ]
}

