//
//  MovieDTO.swift
//  Megabox
//
//  Created by 권예원 on 10/31/25.
//

import Foundation
import SwiftUI

struct MovieDTO : Codable {
    let id :String
    let title : String
    let ageRating : String
    let schedules : [ScheduleDTO]
    
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case ageRating = "age_rating"
        case schedules
    }
}

struct MovieMapper {
    static func toDomain(from dto: MovieDTO) -> (Movie, [Theater], [Room], [Show]) {
        
        let runningTime = dto.schedules.first?
            .areas.first?
            .items.first?
            .showtimes.first
            .map { ShowTimeMapper.runningTime(from: $0) } ?? 0

        let movie = Movie(
            id: dto.id,
            title: dto.title,
            grade: dto.ageRating,
            poster: Image(dto.title),
            runningTime: runningTime
        )
        
        var allTheaters: [Theater] = []
        var allRooms: [Room] = []
        var allShows: [Show] = []
        
        for scheduleDTO in dto.schedules {
            let (theater, room, show) = ScheduleMapper.toDomain(from: scheduleDTO, movieId: dto.id)
            
            allTheaters.append(contentsOf: theater)
            allRooms.append(contentsOf: room)
            allShows.append(contentsOf: show)
            
        }
        print("🎬 변환된 영화:", dto.title, "상영 수:", allShows.count)
        let uniqueTheaters = Array(Set(allTheaters))

        return (movie, uniqueTheaters, allRooms, allShows)
    }
}
