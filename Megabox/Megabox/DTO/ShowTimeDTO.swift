//
//  ShowTimeDTO.swift
//  Megabox
//
//  Created by 권예원 on 10/31/25.
//

import Foundation

struct ShowTimeDTO: Codable {
    let start: String?
    let end: String?
    let available: Int
    let total: Int
}

struct ShowTimeMapper {
    static func toDomain(from dto: ShowTimeDTO, movieId: String, theaterId: String, roomId: String) -> Show {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        formatter.locale = Locale(identifier: "ko_KR")
        formatter.timeZone = TimeZone(identifier: "Asia/Seoul")

        let startStr = dto.start ?? "00:00"
        let endStr = dto.end ?? startStr
        let startAt = formatter.date(from: startStr) ?? Date()
        let endAt = formatter.date(from: endStr) ?? startAt

        let bookedSeats = dto.total - dto.available

        let showId = "\(movieId)_\(theaterId)_\(roomId)_\(startStr)"
        
        return Show(
            id: showId,
            movieId: movieId,
            theaterId: theaterId,
            roomId: roomId,
            startAt: startAt,
            totalSeats: dto.total,
            bookedSeats: bookedSeats
        )
    }
    
    static func runningTime(from dto: ShowTimeDTO) -> Int {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        guard
            let startStr = dto.start,
            let endStr = dto.end,
            let start = formatter.date(from: startStr),
            let end = formatter.date(from: endStr)
        else { return 0 }

        return Int(end.timeIntervalSince(start) / 60)
    }
}

