//
//  BookRowView.swift
//  lightNovelLover
//
//  Created by Shiroha on 2021/12/17.
//

import SwiftUI

struct BookRowView: View {
    let book: Book
    var body: some View {
        HStack {
            //Image("test_image")
            AsyncImage(url: URL(string: book.imageLink)) { image in
                image
                    .resizable()
                    .scaledToFill()
            } placeholder: {
                Color.gray
            }
            .frame(width: 90, height: 160)
            Spacer()
            Spacer()
            VStack(alignment: .leading) {
                Text("書名: " + book.name)
                Text("作者: " + book.author)
                Text("出版社: " + book.publisher)
                Text("出版日: " + book.publishedDate)
            }
        }
    }
}

struct BookRowView_Previews: PreviewProvider {
    static var previews: some View {
        BookRowView(book: Book(name: "悪役令嬢、拾いました! ～しかも可愛いので、妹として大事にしたいと思います～ (2)", author: "玉響なつめ",  publisher: "アース・スターノベル", publishedDate: "12/15", imageLink: "https://images-na.ssl-images-amazon.com/images/P/4815613486.09._SCLZZZZZZZ_.jpg"))
    }
}
