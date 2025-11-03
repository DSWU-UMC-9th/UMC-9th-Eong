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
    let showtimes : [ShowTimeDTO]
}

struct ItemMapper {
    static func toDomain(from dto: ItemDTO, movieId: String, theaterId: String, date:String) -> (Room, [Show]){
        let roomId = "\(theaterId)_\(dto.auditorium)_\(date)"
        let room = Room(
                    id: roomId,
                    theaterId: theaterId,
                    name: dto.auditorium
                )
        let shows = dto.showtimes.map {
            ShowTimeMapper.toDomain(
                            from: $0,
                            movieId: movieId,
                            theaterId: theaterId,
                            roomId: roomId,
                            date: date
                        )
        }
        return (room, shows)
    }
}
