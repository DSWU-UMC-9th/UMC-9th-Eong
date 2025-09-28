//
//  MegaboxApp.swift
//  Megabox
//
//  Created by 권예원 on 9/18/25.
//

import SwiftUI

@main
struct MegaboxApp: App {
    var body: some Scene {
        WindowGroup {
            LoginView(viewModel: LoginViewModel())
        }
    }
}
