//
//  MainTabView.swift
//  Megabox
//
//  Created by 권예원 on 10/3/25.
//

import SwiftUI

struct MainTabView: View {
    var body: some View {
        tabBar
    }
    
    private var tabBar: some View {
        TabView {
            HomeView()
            .tabItem {
                Image(systemName: "house.fill")
                Text("홈") }
            Text("바로예매")
            .tabItem {
                Image(systemName: "play.laptopcomputer")
                Text("바로예매") }
            Text("모바일 오더")
            .tabItem {
                Image(systemName: "popcorn")
                Text("모바일 오더") }
            UserInfoView()
            .tabItem {
                Image(systemName: "person")
                Text("마이페이지") } }
    }
}

#Preview {
    MainTabView()
}
