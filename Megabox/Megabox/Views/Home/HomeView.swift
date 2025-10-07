//
//  HomeView.swift
//  Megabox
//
//  Created by 권예원 on 10/3/25.
//

import SwiftUI

struct HomeView: View {
    @Bindable var viewModel: HomeViewModel
    @State private var selected:SegmentButtons.Section = .chart
    @Environment(Router.self) private var router
    
    var body: some View {
        ScrollView {
            LazyVStack{
                Header()
                    .padding(.bottom, 9)
                SegmentButtons(selected: $selected)
                    .padding(.bottom, 25)
                if selected == .chart {
                    MovieCardList(movies: viewModel.movies, isUpcoming: false){selectedMovie in
                        viewModel.selectedMovie = selectedMovie
                        router.push(.movieDetail)
                    }
                    .padding(.bottom, 38.5)
                } else if selected == .upcoming {
                    MovieCardList(movies: viewModel.upcomings, isUpcoming: true){
                        selectedMovie in
                        viewModel.selectedMovie = selectedMovie
                        router.push(.movieDetail)
                    }
                    .padding(.bottom, 38.5)
                }
                
                MovieFeed(feeds: viewModel.feeds)
            }
            .padding(.horizontal, 16)
        }
    }
}

// 미리보기
struct HomeView_Preview: PreviewProvider {
    static var devices = ["iPhone 11", "iPhone 16 Pro Max"]
    
    static var previews: some View {
        ForEach(devices, id: \.self) { device in
            HomeView(viewModel: HomeViewModel())
                .environment(Router())
                .previewDevice(PreviewDevice(rawValue: device))
                .previewDisplayName(device)
        }
    }
}
