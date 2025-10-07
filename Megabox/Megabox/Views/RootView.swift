//
//  RootView.swift
//  Megabox
//
//  Created by 권예원 on 10/7/25.
//

import SwiftUI


// 전체 네비게이션 컨테이너
struct RootView: View {
    @Environment(Router.self) private var router
    @State private var homeViewModel = HomeViewModel()

    var body: some View {
        @Bindable var router = router 

        NavigationStack(path: $router.path) {
            LoginView(viewModel: LoginViewModel())
                .navigationDestination(for: Route.self) { route in
                    switch route {
                    case .mainTab:
                        MainTabView(homeViewModel: homeViewModel)
                    case .home:
                        HomeView(viewModel: homeViewModel)
                    case .userSetting:
                        UserSettingView()
                    case .movieDetail:
                        MovieDetailView(viewModel: homeViewModel)
                    }
                }
        }
    }
}
#Preview {
    RootView()
        .environment(Router())  
}

