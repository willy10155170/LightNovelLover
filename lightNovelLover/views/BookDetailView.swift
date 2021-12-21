//
//  BookDetailView.swift
//  lightNovelLover
//
//  Created by Shiroha on 2021/12/18.
//

import SwiftUI

struct BookDetailView: View {
    let book: Book
    var body: some View {
        GeometryReader { geometry in
            ScrollView(.vertical) {
                AsyncImage(url: URL(string: book.imageLink)) { image in
                    image
                        .resizable()
                        .scaledToFill()
                } placeholder: {
                    Color.gray
                }
                .frame(width: geometry.size.width - 20)
                Text("書名: " + book.name)
                Text("作者: " + book.author)
                Text("插畫: " + book.illustrator)
                Text("出版社: " + book.publisher)
                Text("出版日: " + book.publishedDate)
                Text("系列: " + book.series)
                Text("簡介: " + book.description)
                
                Link(destination: URL(string: book.bwLink)!) {
                    Text("前往BOOK☆WALKER購買↗")
                }
                Link(destination: URL(string: book.amLink)!) {
                    Text("前往Amazon購買↗")
                }
            }
            .frame(width: geometry.size.width)

        }
        
    }
}

struct BookDetailView_Previews: PreviewProvider {
    static var previews: some View {
        BookDetailView(book: Book(name: "悪役令嬢、拾いました! ～しかも可愛いので、妹として大事にしたいと思います～ (2)", author: "玉響なつめ",  publisher: "アース・スターノベル", publishedDate: "12/15", imageLink: "https://images-na.ssl-images-amazon.com/images/P/4815613486.09._SCLZZZZZZZ_.jpg"))
    }
}
