//
//  SplashView.swift
//  Megabox
//
//  Created by 권예원 on 9/18/25.
//

import SwiftUI

struct SplashView: View {
    @Environment(Router.self) private var router
    @State private var isActive = false
    
    var body: some View {
        if isActive {
            RootView()
                .environment(router)
        }else{
            ZStack{
                Color.white
                Image(.meboxLogo1)
                    .resizable()
                    .frame(width: 249, height: 84)
            }
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                    isActive.toggle()
                }
            }
        }
    }
}

#Preview {
    SplashView()
}
