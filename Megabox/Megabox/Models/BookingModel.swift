//
//  BookingModel.swift
//  Megabox
//
//  Created by 권예원 on 10/11/25.
//

import SwiftUI

struct Movie:Identifiable, Equatable {
    let id: String
    let title: String
    let grade: String
    let poster: Image
    let runningTime: Int
}

struct Theater : Identifiable, Hashable {
    let id: String
    let name: String
}

struct Room : Identifiable {
    let id: String
    let theaterId: String
    let name: String
}

struct Show : Identifiable {
    let id:String
    let movieId: String
    let theaterId: String
    let roomId: String
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

