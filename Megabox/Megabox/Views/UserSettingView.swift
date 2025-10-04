//
//  UserSettingView.swift
//  Megabox
//
//  Created by 권예원 on 9/28/25.
//

import SwiftUI

struct UserSettingView: View {
    
    @AppStorage("id") var id : String = "lee"
    @AppStorage("userName") var userName : String = "이상원"
    
    @State private var tempName: String = ""
    
    var body: some View {
        VStack {
            navigationTitle
                .padding(.bottom, 53)
            userInfoText
                .padding(.bottom, 26)
            userIdnName
            Spacer()
        }
        .padding(.horizontal, 16)
        .onAppear {
            tempName = userName
        }
    }
    
    private var navigationTitle: some View {
        HStack{
            Button(action:{}, label: {
                Image(systemName: "arrow.left")
                    .foregroundStyle(.black)
                    .padding(.vertical, 11)
            })
            Spacer()
            Text("회원정보관리")
                .font(.PretendardMedium16)
                .foregroundStyle(.black)
            Spacer()
        }
        .padding(.trailing, 16)
    }
    
    private var userInfoText: some View {
        HStack{
            Text("기본정보")
                .font(.PretendardBold18)
                .foregroundStyle(.black)
            Spacer()
        }
    }
    
    private var userIdnName: some View {
        VStack{
            HStack{
                Text("\(id)")
                    .font(.PretendardMedium18)
                    .foregroundStyle(.black)
                Spacer()
            }
            Divider().foregroundStyle(.gray02)
            Spacer().frame(height: 24)
            HStack{
                TextField("userName", text:$tempName, prompt: Text("\(userName)")
                    .font(.PretendardMedium18)
                    .foregroundStyle(.black))
                Button(action:{
                    userName = tempName
                }, label: {
                    Text("변경")
                        .font(.PretendardMedium10)
                        .foregroundStyle(.gray03)
                })
                .padding(.horizontal, 10)
                .frame(width: 38, height: 20)
                .overlay(
                    RoundedRectangle(cornerRadius: 16)
                        .stroke(.gray03, lineWidth: 1)
                )
                

            }
            Divider().foregroundStyle(.gray02)
        }
    }
}

// 미리보기
struct UserSettingView_Preview: PreviewProvider {
    static var devices = ["iPhone 11", "iPhone 16 Pro Max"]
    
    static var previews: some View {
        ForEach(devices, id: \.self) { device in
            UserSettingView()
                .previewDevice(PreviewDevice(rawValue: device))
                .previewDisplayName(device)
        }
    }
}
