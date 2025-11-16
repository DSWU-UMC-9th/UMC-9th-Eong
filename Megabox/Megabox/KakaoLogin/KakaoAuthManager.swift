//
//  KakaoAuthManager.swift
//  Megabox
//
//  Created by 권예원 on 11/9/25.
//

import Foundation
import Alamofire

class KakaoAuthManager {
    static let shared = KakaoAuthManager()
    private init() {}

    func requestAccessToken(with code: String) {
        let url = "https://kauth.kakao.com/oauth/token"
        let params: [String: String] = [
            "grant_type": "authorization_code",
            "client_id": "5ac254203daf4960a0d4e513efd4e89f",
            "redirect_uri": "kakaocccb7af201e8be88e68a195f427f0667://oauth",
            "code": code
        ]

        let headers: HTTPHeaders = [
            "Content-Type": "application/x-www-form-urlencoded"
        ]

        AF.request(
            url,
            method: .post,
            parameters: params,
            encoder: URLEncodedFormParameterEncoder.default,
            headers: headers
        )
        .responseDecodable(of: KakaoTokenResponse.self) { response in
            switch response.result {
            case .success(let token):
                print("🎫 Access Token:", token.accessToken)

            case .failure(let error):
                print("❌ Token 요청 실패:", error)
            }
        }
    }


    func getUserInfo(token: String) {
        let url = "https://kapi.kakao.com/v2/user/me"
        let headers: HTTPHeaders = ["Authorization": "Bearer \(token)"]

        AF.request(url, headers: headers)
            .responseDecodable(of: KakaoUserInfo.self) { response in
                switch response.result {
                case .success(let user):
                    print("사용자 정보:", user)
                case .failure(let error):
                    print("사용자 정보 요청 실패:", error)
                }
            }
    }
}

struct KakaoTokenResponse: Decodable {
    let tokenType: String
    let accessToken: String
    let expiresIn: Int
    let refreshToken: String
    let refreshTokenExpiresIn: Int?
    let scope: String?

    enum CodingKeys: String, CodingKey {
        case tokenType = "token_type"
        case accessToken = "access_token"
        case expiresIn = "expires_in"
        case refreshToken = "refresh_token"
        case refreshTokenExpiresIn = "refresh_token_expires_in"
        case scope
    }
}

struct KakaoUserInfo: Decodable {
    let id: Int
    let kakaoAccount: KakaoAccount?

    struct KakaoAccount: Decodable {
        let email: String?
        let profile: Profile?

        struct Profile: Decodable {
            let nickname: String?
            let profileImageUrl: String?
        }
    }
}
