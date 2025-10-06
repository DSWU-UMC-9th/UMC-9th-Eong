//
//  MovieFeed.swift
//  Megabox
//
//  Created by 권예원 on 10/6/25.
//

import SwiftUI

struct MovieFeed: View {
    var body: some View {
        VStack(){
            HStack{
                Text("알고보면 더 재밌는 무비피드")
                    .font(.PretendardSemiBold24)
                    .foregroundStyle(.black)
                Spacer()
                Image(systemName: "arrow.right")
            }
            .padding(.bottom, 5.5)
            Image(.stillCut)
                .padding(.bottom, 44)
            VStack(spacing:39){
                FeedItem(image: Image(.thumbnail01), title: "9월, 메가박스의 영화들(1) - 명작들의 재개봉’", tag: "<모노노케 히메>,<퍼펙트 블루>")
                
                FeedItem(image: Image(.thumbnail02), title: "메가박스 오리지널 티켓 Re.37 <얼굴>", tag: "영화 속 양극적인 감정의 대비")
            }

        }
    }
}

struct FeedItem : View {
    let image: Image
    let title :String
    let tag: String
    
    var body: some View {
        HStack{
            image
                .resizable()
                .frame(width: 100, height: 100)
            Spacer()
            VStack(alignment: .leading){
                Text(title)
                    .font(.PretendardSemiBold18)
                    .frame(maxWidth: 285,maxHeight: 45, alignment: .leading)
                    .padding(.bottom, 25)

                Text(tag)
                    .font(.PretendardSemiBold13)
                    .foregroundStyle(.gray03)
            }

        }
    }
}

#Preview {
    MovieFeed()
}
