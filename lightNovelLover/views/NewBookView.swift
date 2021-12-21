//
//  NewBookView.swift
//  lightNovelLover
//
//  Created by Shiroha on 2021/12/16.
//

import SwiftUI

struct NewBookView: View {
    @StateObject var bookModel = BookModel()
    @State private var newBookTime = 0
    var body: some View {
        NavigationView {
            VStack {
                Picker(selection: $newBookTime) {
                    Text("本週").tag(0)
                    Text("下週").tag(1)
                } label: {
                    Text("選擇時間")
                }
                .onChange(of: newBookTime) { tag in
                    bookModel.NewBookList = []
                    bookModel.LoadNewBook(timeRange: newBookTime)
                }
                .pickerStyle(.segmented)
                List{
                    ForEach(bookModel.NewBookList){ book in
                        NavigationLink {
                            BookDetailView(book: book)
                        } label: {
                            BookRowView(book: book)
                        }
                    }
                }
                .overlay {
                    if bookModel.NewBookList.isEmpty {
                        ProgressView()
                    }
                }
                .refreshable {
                    bookModel.LoadNewBook(timeRange: newBookTime)
                }
            }
            .navigationTitle("本週新書")
        }
        .onAppear {
            bookModel.LoadNewBook(timeRange: newBookTime)
        }
    }
}

struct NewBookView_Previews: PreviewProvider {
    static var previews: some View {
        NewBookView()
    }
}
