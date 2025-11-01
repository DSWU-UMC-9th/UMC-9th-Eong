//
//  ItemDTO.swift
//  Megabox
//
//  Created by 권예원 on 10/31/25.
//

import Foundation

struct ItemDTO : Codable {
    let auditorium : String
    let format : String
    let showTimes : [ShowTimeDTO]
}

struct ItemMapper {
    static func toDomain(from dto: ItemDTO, movieId: String, theaterId: String) -> (Room, [Show]){
        let roomId = "\(theaterId)_\(dto.auditorium)"
        let room = Room(
                    id: roomId,
                    theaterId: theaterId,
                    name: dto.auditorium
                )
        let shows = dto.showTimes.map {
            ShowTimeMapper.toDomain(from: $0, movieId: movieId, theaterId: theaterId, roomId: roomId)
        }
        return (room, shows)
    }
}
