//
//  ScheduleDTO.swift
//  Megabox
//
//  Created by 권예원 on 10/31/25.
//

import Foundation

struct ScheduleDTO : Codable {
    let date : String
    let areas : [AreaDTO]
}

struct ScheduleMapper {
    static func toDomain(from dto: ScheduleDTO, movieId : String) -> ([Theater], [Room], [Show]){
        var allTheaters : [Theater] = []
        var allRooms : [Room] = []
        var allShows : [Show] = []
        
        for areaDTO in dto.areas {
            let (theater, rooms, shows) = AreaMapper.toDomain(from: areaDTO, movieId: movieId)
            
            allTheaters.append(theater)
            allRooms.append(contentsOf : rooms)
            allShows.append(contentsOf : shows)
        }
        
        return (allTheaters, allRooms, allShows)
    }
}
