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
    
    init(){
        KeychainService.shared.resetKeychain()
        
        let id = "e0ng"
        let pwd = "1234"
        let name = "홍길동"
        
        if KeychainService.shared.loadUserID() == nil {
            KeychainService.shared.saveUserID(id)
        }
        if KeychainService.shared.loadPassword() == nil {
            KeychainService.shared.savePassword(pwd)
        }
        UserDefaults.standard.set(name, forKey: "userName_\(id)")

        print("✅ 기본 계정 등록 완료 — \(id) / \(pwd) / \(name)")
        
    }
    
    var body: some Scene {
        WindowGroup {
            SplashView()
                .environment(router)
        }
    }
}
