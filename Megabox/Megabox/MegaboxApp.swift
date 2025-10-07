//
//  MegaboxApp.swift
//  Megabox
//
//  Created by 권예원 on 9/18/25.
//

import SwiftUI

@main
struct MegaboxApp: App {
    @State private var router = Router()
    
    @AppStorage("id") var id : String = ""
    @AppStorage("pwd") var pwd : String = ""
    
    init(){
            id = "e0ng"
            pwd = "1234"
    }
    
    var body: some Scene {
        WindowGroup {
            RootView()
                .environment(router)
        }
    }
}
