//
//  UserInfoView.swift
//  Megabox
//
//  Created by 권예원 on 9/28/25.
//

import SwiftUI

struct UserInfoView: View {
    @Environment(Router.self) private var router
    @AppStorage("userName") var userName: String = "이*원"
    
    var body: some View {
            VStack{
                header
                    .padding(.top, 59)
                    .padding(.bottom, 15)
                memberShip
                    .padding(.bottom, 33)
                statusInfo
                    .padding(.bottom, 33)
                bottomImage
                Spacer()
            }
            .padding(.horizontal, 15)


    }
    
    private var header: some View {
        VStack(spacing: 5){
            HStack(spacing: 5){
                Text("\(userName)님")
                    .font(.PretendardBold24)
                    .foregroundColor(.black)
                
                Text("WELCOME")
                    .font(.PretendardMedium14)
                    .foregroundStyle(.white)
                    .padding(.horizontal, 8)
                    .padding(.vertical, 4)
                    .background(
                        RoundedRectangle(cornerRadius: 6)
                            .foregroundStyle(.tag)
                    )
                
                Spacer()
                
                Button(action: {
                    router.push(.userSetting)
                }, label: {
                    Text("회원정보")
                        .font(.PretendardSemiBold14)
                        .foregroundStyle(.white)
                })
                .padding(4)
                .frame(width:72)
                .background(
                    RoundedRectangle(cornerRadius: 16)
                        .foregroundStyle(.gray07)
                )
            }
            
            
            HStack(spacing : 9){
                Text("멤버십 포인트")
                    .font(.PretendardSemiBold14)
                    .foregroundStyle(.gray04)
                Text("500P")
                    .font(.PretendardMedium14)
                    .foregroundStyle(.black)
                Spacer()
            }
        }
    }
    
    private var memberShip: some View {
        Button(action: {}, label: {
            HStack(spacing:3){
                Text("클럽 멤버십")
                    .font(.PretendardSemiBold16)
                    .foregroundStyle(.white)
                Image(systemName:"chevron.right")
                    .foregroundStyle(.white)
                Spacer()
            }
            .padding(.horizontal, 12)
            .padding(.vertical, 12)
            .frame(maxWidth: .infinity)  // ✅ 버튼 영역을 부모 너비로 확장
            .background(
                RoundedRectangle(cornerRadius: 8)
                    .fill(
                        LinearGradient(colors: [.gradient01, .gradient02, .gradient03], startPoint: .leading, endPoint: .trailing)
                    )
            )
        })

    }
    
    struct StatusItem: View {
        let title: String
        let value: String

        var body: some View {
            VStack(spacing: 9) {
                Text(title)
                    .font(.PretendardSemiBold16)
                    .foregroundStyle(.gray02)
                Text(value)
                    .font(.PretendardSemiBold18)
                    .foregroundStyle(.black)
            }
        }
    }

    private var statusInfo: some View {
        HStack {
            StatusItem(title: "쿠폰", value: "2")
            
            Spacer()
            Divider().frame(width: 1, height: 31)
            Spacer()
            
            StatusItem(title: "스토어 교환권", value: "0")
            
            Spacer()
            Divider().frame(width: 1, height: 31)
            Spacer()
            
            StatusItem(title: "모바일 티켓", value: "0")
        }
        .padding(.horizontal, 24)
        .padding(.vertical, 12)
        .overlay(
            RoundedRectangle(cornerRadius: 8)
                .stroke(.gray02, lineWidth: 1)
        )
    }

    struct BottomItem: View{
        let image: String
        let text: String
        
        var body: some View{
            VStack(spacing:12){
                Image(image)
                    .resizable()
                    .frame(width: 36, height: 36)
                Text(text)
                    .font(.PretendardMedium16)
                    .foregroundStyle(.black)
            }
        }
        
    }
    
    private var bottomImage: some View {
        HStack{
            
            BottomItem(image: "movie", text:"영화별예매")
            Spacer()
            BottomItem(image: "pin", text:"극장별예매")
            Spacer()
            BottomItem(image: "special", text:"특별관예매")
            Spacer()
            BottomItem(image: "popcorn", text:"모바일오더")

        }
    }
}


// 미리보기
struct UserInfoView_Preview: PreviewProvider {
    static var devices = ["iPhone 11", "iPhone 16 Pro Max"]
    
    static var previews: some View {
        ForEach(devices, id: \.self) { device in
            UserInfoView()
                .environment(Router())
                .previewDevice(PreviewDevice(rawValue: device))
                .previewDisplayName(device)
        }
    }
}
