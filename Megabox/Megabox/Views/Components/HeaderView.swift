//
//  HeaderView.swift
//  Megabox
//
//  Created by 권예원 on 10/6/25.
//

import SwiftUI

struct HeaderView: View {
    var body: some View {
        VStack{
            Group{
                Image(.meboxLogo)
                    .resizable()
                    .frame(width: 149, height: 30)
                
                HStack{
                    headerButtonItem(buttonName: "홈", buttonColor: .black)
                    Spacer()
                    headerButtonItem(buttonName: "이벤트", buttonColor: .gray04)
                    Spacer()
                    headerButtonItem(buttonName: "스토어", buttonColor: .gray04)
                    Spacer()
                    headerButtonItem(buttonName: "선호극장", buttonColor: .gray04)
                }
                .frame(width: 320)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
        }
    }
}

struct headerButtonItem: View {
    let buttonName: String
    let buttonColor: Color
    
    var body: some View {
        Button(action: {
            
        }, label: {
            Text(buttonName)
                .font(.PretendardSemiBold24)
                .foregroundStyle(buttonColor)
        })
    }
}


#Preview {
    HeaderView()
}
