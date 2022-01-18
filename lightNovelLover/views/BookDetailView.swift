//
//  BookDetailView.swift
//  lightNovelLover
//
//  Created by Shiroha on 2021/12/18.
//

import SwiftUI

struct BookDetailView: View {
    let book: Book
    @EnvironmentObject var bookDataModel: BookDataModel
    @State var showSecondPage = false
    var body: some View {
        GeometryReader { geometry in
            ScrollView(.vertical, showsIndicators: false) {
//                Button("加到我的最愛") {
//                    bookDataModel.addFavorite(book: book)
//                }
                Button("新增至書櫃") {
                showSecondPage = true
                }
                .sheet(isPresented: $showSecondPage) {
                    addBookView(book: book, showSecondPage: $showSecondPage, inputByhtml: .constant(false))
                }
                AsyncImage(url: URL(string: book.imageLink)) { image in
                    image
                        .resizable()
                        .scaledToFill()
                } placeholder: {
                    Color.gray
                }
                .frame(width: geometry.size.width - 20)
                Text(book.name)
                    .font(.system(size: 25))
                    .fontWeight(.heavy)
                    .frame(width: geometry.size.width - 20)
                VStack(alignment: .leading) {
                    Spacer()
                    Text("作者:   " + book.author)
                        .font(.system(size: 20))
                    Text("插畫:   " + book.illustrator)
                        .font(.system(size: 20))
                    Text("出版社:  " + book.publisher)
                        .font(.system(size: 20))
                    Text("出版日:  " + book.publishedDate)
                        .font(.system(size: 20))
                    Text("系列:   " + book.series)
                        .font(.system(size: 20))
                    Spacer()
                    Text(book.description)
                    Spacer()
                }
                .frame(width: geometry.size.width - 20)
                Link(destination: URL(string: book.bwLink)!) {
                    Text("前往BOOK☆WALKER購買↗")
                }
                Spacer()
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
