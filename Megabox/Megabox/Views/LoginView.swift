//
//  LoginView.swift
//  Megabox
//
//  Created by 권예원 on 9/18/25.
//

import SwiftUI

struct LoginView: View {
    
    @Bindable var viewModel: LoginViewModel
    
    @AppStorage("id") var id:String = ""
    @AppStorage("pwd") var pwd:String = ""
    
    init(viewModel:LoginViewModel){
        self.viewModel = viewModel
    }
    
    var body: some View {
        VStack{
            Header
            Spacer()
            TextFieldGroup
            ButtonGroup
                .padding(.bottom, 35)
            SocialButtonGroup
                .padding(.bottom, 39)
            UMCImage
                .padding(.bottom, 91)
        }
        .padding(.horizontal, 16)
    }
    
    // 로그인 텍스트
    private var Header: some View {
        HStack {
            Text("로그인")
                .font(.PretendardSemiBold24)
                .foregroundStyle(.black)
        }
    }
    
    // 아이디 및 비밀번호 입력
    private var TextFieldGroup: some View {
        VStack {
            VStack{
                TextField("아이디", text: $viewModel.loginModel.id)
                    .font(.PretendardMedium16)
                    .foregroundStyle(.gray03)
                Divider().foregroundStyle(.gray02)
                Spacer().frame(height:40)
                SecureField("비밀번호", text: $viewModel.loginModel.pwd)
                    .font(.PretendardMedium16)
                    .foregroundStyle(.gray03)
                Divider().foregroundStyle(.gray02)
                    .padding(.bottom, 74.98)
            }.frame(height:86)
        }

    }
    // 로그인 + 회원가입
    private var ButtonGroup: some View {
        VStack{
            
            Button(action: {
                id = viewModel.loginModel.id
                pwd = viewModel.loginModel.pwd
            }, label: {
                ZStack{
                    RoundedRectangle(cornerRadius: 10)
                        .fill(.purple03)
                        .frame(height: 54)
                    Text("로그인")
                        .font(.PretendardBold18)
                        .foregroundStyle(Color.white)
                        .frame(width: 47, height: 36)
                }
            })
            Spacer().frame(height:17)
            Button("회원가입"){
            }
            .font(.PretendardMedium13)
            .foregroundStyle(.gray04)
        }
        
    }
    
    // 소셜 미디어
    private var SocialButtonGroup: some View {
        HStack {
            Button(action:{}, label: {
                Image(.naver)
            })
            Spacer()

            Button(action:{}, label:{
                Image(.kakao)
            })
            Spacer()
            Button(action:{}, label: {
                Image(.apple)
            })
        }
        .frame(width: 266, height: 40)
        
    }
    
    // 홍보 이미지
    private var UMCImage: some View {
        Image(.umc1)
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(height: 266)
            
    }
}
            


// 미리보기
struct LoginView_Preview: PreviewProvider {
    static var devices = ["iPhone 11", "iPhone 16 Pro Max"]
    
    static var previews: some View {
        ForEach(devices, id: \.self) { device in
            LoginView(viewModel: LoginViewModel())
                .previewDevice(PreviewDevice(rawValue: device))
                .previewDisplayName(device)
        }
    }
}
