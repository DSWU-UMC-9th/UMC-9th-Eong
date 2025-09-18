//
//  SplashView.swift
//  Megabox
//
//  Created by 권예원 on 9/18/25.
//

import SwiftUI

struct SplashView: View {
    var body: some View {
        ZStack{
            Color.white
            Image(.meboxLogo1)
                .resizable()
                .frame(width: 249, height: 84)
        }
    }
}

#Preview {
    SplashView()
}
