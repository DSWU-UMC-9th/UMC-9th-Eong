//
//  movieModel.swift
//  Megabox
//
//  Created by 권예원 on 10/5/25.
//

import SwiftUI

struct MovieModel : Identifiable {
    let id = UUID()
    let movieImage: Image
    let movieName: String
    let movieViewers: String
}

