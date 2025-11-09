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
    @State private var isLoggedIn: Bool = false

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
                .onAppear{
                    checkLoginStatus()
                    if isLoggedIn {
                        router.reset()
                        router.push(.mainTab)
                    }
                }
        }
    }
    
    private func checkLoginStatus() {
        if let savedID = KeychainService.shared.loadUserID(),
           KeychainService.shared.hasToken(for: savedID) {
            isLoggedIn = true
        } else {
            isLoggedIn = false
        }
    }
}
#Preview {
    RootView()
        .environment(Router())  
}

