//
//  MegaboxApp.swift
//  Megabox
//
//  Created by 권예원 on 9/18/25.
//

import SwiftUI

@main
struct MegaboxApp: App {
    @AppStorage("id") var id : String = ""
    @AppStorage("pwd") var pwd : String = ""
    
    init(){
        if id.isEmpty {
            id = "e0ng"
        }
        if pwd.isEmpty {
            pwd = "1234"
        }
    }
    
    var body: some Scene {
        WindowGroup {
            LoginView(viewModel: LoginViewModel())
        }
    }
}
