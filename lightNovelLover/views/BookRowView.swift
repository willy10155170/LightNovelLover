//
//  BookRowView.swift
//  lightNovelLover
//
//  Created by Shiroha on 2021/12/17.
//

import SwiftUI

struct BookRowView: View {
    let book: Book
    @EnvironmentObject var bookDataModel: BookDataModel
    var body: some View {
        HStack(alignment: .top) {
            AsyncImage(url: URL(string: book.imageLink)) { image in
                image
                    .resizable()
                    .scaledToFill()
            } placeholder: {
                //Color.gray
                ProgressView()
            }
            .frame(width: 90, height: 160)
            Spacer()
            Spacer()
            VStack(alignment: .leading) {
                Text(book.name)
                    .font(.system(size: 18))
                    .fontWeight(.heavy)
                    .foregroundColor(.blue)
                    .lineLimit(2)
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
