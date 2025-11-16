//
//  APIResponse.swift
//  Megabox
//
//  Created by 권예원 on 10/31/25.
//

import Foundation

struct APIResponse : Codable {
    let status: String
    let message: String
    let data: MovieScheduleData
}

struct MovieScheduleData: Codable {
    let movies : [MovieDTO]
}




