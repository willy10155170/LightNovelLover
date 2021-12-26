//
//  BookNewsRowView.swift
//  lightNovelLover
//
//  Created by Shiroha on 2021/12/25.
//

import SwiftUI

struct BookNewsRowView: View {
    let news: News
    var body: some View {
        HStack {
            AsyncImage(url: URL(string: news.thumbnail)) { image in
                image
                    .resizable()
                    .scaledToFit()
            } placeholder: {
                ProgressView()
            }
            .frame(width: 90, height: 160)
            Spacer()
            Spacer()
            VStack(alignment: .leading) {
                Text("▶ " + news.title)
                    .font(.system(size: 18))
                    .fontWeight(.heavy)
                    .foregroundColor(.blue)
                    .lineLimit(2)
                Text(news.description)
            }
        }
    }
}

struct BookNewsRowView_Previews: PreviewProvider {
    static var previews: some View {
        BookNewsRowView(news: News(categories: [lightNovelLover.categories(color: "green", name: "イベント")], description: "電撃文庫刊『魔法科高校の劣等生』のオンライン展示会が「Anique」にて開催...", is_pr: false, path: "/articles/113011", thumbnail: "https://assets.ln-news.com/images/medias/64178be7fdd94f4b983081c7a24d7bd3.jpg", time: "2021/12/25", title: "『魔法科高校の劣等生』のオンライン展示会が「Anique」にて開催中　オリジナルグッズの販売なども実施"))
    }
}
