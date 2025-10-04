//
//  HomeView.swift
//  Megabox
//
//  Created by 권예원 on 10/3/25.
//

import SwiftUI

struct HomeView: View {
    
    var body: some View {
        ScrollView {
            VStack{
                header
            }
            .padding(.horizontal, 16)
        }
    }
    
    private var header : some View {
        VStack{
            Group{
                Image(.meboxLogo)
                    .resizable()
                    .frame(width: 149, height: 30)

                HStack{
                    Button(action: {
                        
                    }, label: {
                        Text("홈")
                            .font(.PretendardSemiBold24)
                            .foregroundStyle(.black)
                    })
                    Spacer()
                    Button(action: {
                        
                    }, label: {
                        Text("이벤트")
                            .font(.PretendardSemiBold24)
                            .foregroundStyle(.gray04)
                    })
                    Spacer()
                    Button(action: {
                        
                    }, label: {
                        Text("스토어")
                            .font(.PretendardSemiBold24)
                            .foregroundStyle(.gray04)
                    })
                    Spacer()
                    Button(action: {
                        
                    }, label: {
                        Text("선호극장")
                            .font(.PretendardSemiBold24)
                            .foregroundStyle(.gray04)
                    })
                }
                .frame(width: 320)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
        }

    }
}

// 미리보기
struct HomeView_Preview: PreviewProvider {
    static var devices = ["iPhone 11", "iPhone 16 Pro Max"]
    
    static var previews: some View {
        ForEach(devices, id: \.self) { device in
            HomeView()
                .previewDevice(PreviewDevice(rawValue: device))
                .previewDisplayName(device)
        }
    }
}
