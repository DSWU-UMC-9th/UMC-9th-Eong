//
//  MainTabView.swift
//  Megabox
//
//  Created by 권예원 on 10/3/25.
//

import SwiftUI

struct MainTabView: View {
    @Bindable var homeViewModel: HomeViewModel
    var body: some View {
        tabBar
    }
    
    private var tabBar: some View {
        TabView {
                    Tab("홈", systemImage: "house.fill") {
                        HomeView(viewModel: homeViewModel)
                    }
                    Tab("바로예매", systemImage: "play.laptopcomputer") {
                        Text("바로예매")
                    }
                    Tab("모바일 오더", systemImage: "popcorn") {
                        Text("모바일 오더")
                    }
                    Tab("마이페이지", systemImage: "person") {
                        UserInfoView()
                    }
                }
                .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    MainTabView(homeViewModel: HomeViewModel())
        .environment(Router())
}
