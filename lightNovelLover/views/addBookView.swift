//
//  addBookView.swift
//  lightNovelLover
//
//  Created by Shiroha on 2022/1/17.
//

import SwiftUI

struct addBookView: View {
    @EnvironmentObject var bookDataModel: BookDataModel
    @State var book = Book()
    @Binding var showSecondPage: Bool
    @Binding var inputByhtml: Bool
    @State private var inputHtml = ""
    @StateObject var bookInfoModel = BookInfoModel()
    var body: some View {
        if inputByhtml == true {
            VStack{
                TextField("輸入你的網址（ＢＷ）", text: $inputHtml)
                    .textFieldStyle(.roundedBorder)
            }
            Button("取得") {
                bookInfoModel.LoadSingleBook(html: inputHtml) { re in
                    book = re
                }
                inputByhtml = false
            }
        }
        if inputByhtml == false {
            VStack {
                Form {
                    HStack {
                        Text("書名： ")
                        TextField(book.name , text: $book.name)
                            .textFieldStyle(.roundedBorder)
                    }
                    HStack {
                        Text("作者： ")
                        TextField(book.author , text: $book.author)
                            .textFieldStyle(.roundedBorder)
                    }
                    HStack {
                        Text("系列： ")
                        TextField(book.series , text: $book.series)
                            .textFieldStyle(.roundedBorder)
                    }
                    HStack{
                        Text("集數： ")
                        TextField(book.ep , text: $book.ep)
                            .textFieldStyle(.roundedBorder)
                    }
                    HStack{
                        Text("畫師： ")
                        TextField(book.illustrator , text: $book.illustrator)
                            .textFieldStyle(.roundedBorder)
                    }
                    HStack{
                        Text("出版社： ")
                        TextField(book.publisher , text: $book.publisher)
                            .textFieldStyle(.roundedBorder)
                    }
                    HStack{
                        Text("出版日： ")
                        TextField(book.publishedDate , text: $book.publishedDate)
                            .textFieldStyle(.roundedBorder)
                    }
                    Group {
                        Text("簡介：")
                        TextEditor(text: $book.description)
                            .border(.blue, width: 2)
                    }
                    Group {
                        Text("新增至")
                        HStack {
                            Button("我的最愛") {
                                book.isFavorite = book.isFavorite * -1
                            }
                            if book.isFavorite == -1 {
                                Image(systemName: "circle")
                            }
                            else {
                                Image(systemName: "circle.fill")
                            }
                        }
                        HStack {
                            Button("購買清單") {
                                book.bought = book.bought * -1
                            }
                            if book.bought == -1 {
                                Image(systemName: "circle")
                            }
                            else {
                                Image(systemName: "circle.fill")
                            }
                        }
                        HStack {
                            Button("閱讀佇列") {
                                book.reading = book.reading * -1
                            }
                            if book.reading == -1 {
                                Image(systemName: "circle")
                            }
                            else {
                                Image(systemName: "circle.fill")
                            }
                        }
                    }
                }
                Button("保存這本書") {
                    bookDataModel.addBook(book: book)
                    showSecondPage = false
                }
            }
            .overlay {
                if book.name == "N/A" && inputHtml == "" {
                    ProgressView()
                }
            }
        }
    }
}

struct addBookView_Previews: PreviewProvider {
    static var previews: some View {
        addBookView(showSecondPage: .constant(false), inputByhtml: .constant(false))
    }
}
