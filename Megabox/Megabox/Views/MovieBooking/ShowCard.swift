//
//  ShowCard.swift
//  Megabox
//
//  Created by 권예원 on 10/12/25.
//

import SwiftUI

struct ShowCard: View {
    @EnvironmentObject var viewModel: BookingViewModel
    let show: Show
    
    var body: some View {
        Button(action: {
            
        }, label: {
            VStack(alignment: .leading, spacing:4){
                Text(timeText(show.startAt))
                    .font(.PretendardBold18)
                    .foregroundStyle(.black)
                Text("~\(timeText(viewModel.endTime(of: show)))")
                    .font(.PretendardRegualr12)
                    .foregroundStyle(.gray03)
                HStack(spacing:0){
                    Text("\(twoDigits(show.remainingSeats))")
                        .font(.PretendardSemiBold14)
                        .foregroundStyle(.purple03)
                    Text("/\(show.totalSeats)")
                        .font(.PretendardSemiBold14)
                        .foregroundStyle(.gray03)
                }
            }
            .padding(10)
            .background(
                RoundedRectangle(cornerRadius: 12)
                    .stroke(.gray02, lineWidth: 1)
            )
        })
    }
    
    private func timeText(_ d: Date) -> String {
        let f = DateFormatter()
        f.locale = Locale(identifier: "ko_KR")
        f.timeZone = TimeZone(identifier: "Asia/Seoul")
        f.dateFormat = "HH:mm"
        return f.string(from: d)
    }
    
    private func twoDigits(_ n: Int) -> String {
        String(format: "%02d", max(0, n))
    }
}

#Preview {
    let vm = BookingViewModel()


    let sample = vm.shows.first
        ?? Show(
            movieId: vm.movies[0].id,
            theaterId: vm.theaters[0].id,
            roomId: vm.rooms[0].id,
            startAt: Date(),
            totalSeats: 116,
            bookedSeats: 107
        )
    ShowCard(show: sample)
        .environmentObject(vm)

}
