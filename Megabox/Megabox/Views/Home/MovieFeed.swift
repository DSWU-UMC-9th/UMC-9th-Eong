//
//  MovieFeed.swift
//  Megabox
//
//  Created by 권예원 on 10/6/25.
//

import SwiftUI

struct MovieFeed: View {
    let feeds: [FeedModel]
    
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
                ForEach(feeds){ feed in
                    HStack{
                        feed.feedImage
                            .resizable()
                            .frame(width: 100, height: 100)
                        Spacer()
                        VStack(alignment: .leading){
                            Text(feed.feedTitle)
                                .font(.PretendardSemiBold18)
                                .frame(maxWidth: 285,maxHeight: 45, alignment: .leading)
                                .padding(.bottom, 25)
                            
                            Text(feed.feedTag)
                                .font(.PretendardSemiBold13)
                                .foregroundStyle(.gray03)
                        }
                    }
                }
                
            }
        }
    }
}


#Preview {
    MovieFeed(feeds:HomeViewModel().feeds)
}
