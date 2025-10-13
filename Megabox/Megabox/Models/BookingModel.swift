//
//  BookingModel.swift
//  Megabox
//
//  Created by 권예원 on 10/11/25.
//

import SwiftUI

struct Movie:Identifiable {
    let id: UUID = UUID()
    let title: String
    let grade: String
    let poster: Image
    let runningTime: Int
}

struct Theater : Identifiable {
    let id: UUID = UUID()
    let name: String
}

struct Room : Identifiable {
    let id: UUID = UUID()
    let theaterId: UUID
    let name: String
}

struct Show : Identifiable {
    let id: UUID = UUID()
    let movieId: UUID
    let theaterId: UUID
    let roomId: UUID
    let startAt: Date
    let totalSeats: Int
    var bookedSeats: Int

    var remainingSeats: Int { max(0, totalSeats - bookedSeats) }
}

struct DayItem: Identifiable {
    var id: UUID = UUID()
    let day: Int
    let date: Date
    let isCurrentMonth: Bool
}

