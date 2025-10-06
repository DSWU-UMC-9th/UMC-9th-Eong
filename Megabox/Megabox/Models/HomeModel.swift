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
    let movieName_Eng: String
    let movieViewers: String
    
    
}

struct FeedModel : Identifiable {
    let id = UUID()
    let feedImage: Image
    let feedTitle: String
    let feedTag: String
    
}

