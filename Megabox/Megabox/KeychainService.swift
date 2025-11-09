//
//  KeychainService.swift
//  Megabox
//
//  Created by 권예원 on 11/8/25.
//

import Foundation
import Security

struct TokenInfo: Codable {
    let accessToken: String
    let refreshToken: String
}

class KeychainService {
    static let shared = KeychainService()
    
    private init() {}
    
    private let service = "com.megabox.userInfo"
    
    @discardableResult
    private func saveTokenInfo(_ tokenInfo: TokenInfo, for account: String) -> OSStatus {
        do {
            let data = try JSONEncoder().encode(tokenInfo)
            
            let query: [String: Any] = [
                kSecClass as String: kSecClassGenericPassword,
                kSecAttrAccount as String: account,
                kSecAttrService as String: service,
                kSecValueData as String: data,
                kSecAttrAccessible as String: kSecAttrAccessibleAfterFirstUnlock
            ]
            
            SecItemDelete(query as CFDictionary)
            
            return SecItemAdd(query as CFDictionary, nil)
        } catch {
            print("JSON 인코딩 실패:", error)
            return errSecParam
        }
    }
    
    private func loadTokenInfo(for account: String) -> TokenInfo? {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: account,
            kSecAttrService as String: service,
            kSecReturnData as String: true,
            kSecMatchLimit as String: kSecMatchLimitOne
        ]
        
        var item: CFTypeRef?
        let status = SecItemCopyMatching(query as CFDictionary, &item)
        
        guard status == errSecSuccess,
              let data = item as? Data else {
            print("토큰 정보 불러오기 실패 - status:", status)
            return nil
        }
        
        do {
            return try JSONDecoder().decode(TokenInfo.self, from: data)
        } catch {
            print("❌ JSON 디코딩 실패:", error)
            return nil
        }
    }
    
    @discardableResult
    private func deleteTokenInfo(for account: String) -> OSStatus {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: account,
            kSecAttrService as String: service
        ]
        
        return SecItemDelete(query as CFDictionary)
    }
    
    // 테스트용 리셋
    public func resetKeychain() {
        let secItemClasses = [
            kSecClassGenericPassword,
            kSecClassInternetPassword,
            kSecClassCertificate,
            kSecClassKey,
            kSecClassIdentity
        ] as [CFString]
        
        for itemClass in secItemClasses {
            let query: [String: Any] = [kSecClass as String: itemClass]
            let status = SecItemDelete(query as CFDictionary)
            if status == errSecSuccess {
                print("✅ \(itemClass) 삭제 성공")
            } else if status == errSecItemNotFound {
                print("⚠️ \(itemClass) 항목 없음 (이미 비어 있음)")
            } else {
                print("❌ \(itemClass) 삭제 실패 — status: \(status)")
            }
        }
        print("🔄 Keychain 전체 초기화 완료")
    }

    
    public func saveToken(_ tokenInfo: TokenInfo, for account: String) {
        let saveStatus = self.saveTokenInfo(tokenInfo, for: account)
        print(saveStatus == errSecSuccess ? "저장 성공" : "저장 실패")
    }
    
    public func loadToken(for account: String) -> TokenInfo? {
        if let loadedToken = self.loadTokenInfo(for: account) {
            print("accessToken:", loadedToken.accessToken)
            print("RefreshToken:", loadedToken.refreshToken)
            return loadedToken
        } else {
            print("토큰 정보 없음")
            return nil
        }
    }
    
    public func deleteToken(for account: String) {
        let deleteStatus = self.deleteTokenInfo(for: account)
        print(deleteStatus == errSecSuccess ? "삭제 성공" : "삭제 실패")
    }
    
    public func hasToken(for account: String) -> Bool {
        return loadTokenInfo(for: account) != nil
    }
    
    public func saveUserID(_ id: String) {
            let tokenInfo = TokenInfo(accessToken: id, refreshToken: "")
            saveTokenInfo(tokenInfo, for: "userID")
    }

    public func savePassword(_ pwd: String) {
        let tokenInfo = TokenInfo(accessToken: pwd, refreshToken: "")
        saveTokenInfo(tokenInfo, for: "userPassword")
    }
    
    public func loadUserID() -> String? {
        loadTokenInfo(for: "userID")?.accessToken
    }
    
    public func loadPassword() -> String? {
        loadTokenInfo(for: "userPassword")?.accessToken
    }

    public func deleteCredentials() {
        deleteTokenInfo(for: "userID")
        deleteTokenInfo(for: "userPassword")
    }

}
