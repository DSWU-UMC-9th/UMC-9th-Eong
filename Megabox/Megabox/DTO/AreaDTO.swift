//
//  AreaDTO 2.swift
//  Megabox
//
//  Created by 권예원 on 10/31/25.
//

import Foundation

struct AreaDTO : Codable {
    let area : String
    let items : [ItemDTO]
}

struct AreaMapper {
    static func toDomain(from dto : AreaDTO, movieId: String) -> (Theater, [Room], [Show]){
        let theaterId = dto.area
        let theater = Theater(id: theaterId, name: dto.area)
        
        var allRooms: [Room] = []
        var allShows: [Show] = []

        for itemDTO in dto.items {
            let (room, shows) = ItemMapper.toDomain(from: itemDTO,
                                                    movieId: movieId,
                                                    theaterId: theaterId)
            allRooms.append(room)
            allShows.append(contentsOf: shows)
        }
        
        return (theater, allRooms, allShows)
    }
}
