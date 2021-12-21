//
//  RankView.swift
//  lightNovelLover
//
//  Created by Shiroha on 2021/12/16.
//

import SwiftUI

struct RankView: View {
    @StateObject var bookModel = BookModel()
    @State private var newBookTime = 0
    var body: some View {
        NavigationView {
            VStack {
                Picker(selection: $newBookTime) {
                    Text("日間").tag(0)
                    Text("週間").tag(1)
                    Text("月間").tag(2)
                } label: {
                    Text("選擇時間")
                }
                .onChange(of: newBookTime) { tag in
                    bookModel.RankList = []
                    bookModel.LoadRank(timeRange: newBookTime)
                }
                .pickerStyle(.segmented)
                List{
                    ForEach(bookModel.RankList){ book in
                        VStack {
                            Text("\(book.rank)位")
                                .font(.system(size: 20))
                                .fontWeight(.heavy)
                                .foregroundColor(.red)
                            NavigationLink {
                                BookDetailView(book: book)
                            } label: {
                                BookRowView(book: book)
                            }
                        }
                    }
                }
                .overlay {
                    if bookModel.RankList.isEmpty {
                        ProgressView()
                    }
                }
            }
            .navigationTitle("銷售排行榜")
        }
        .onAppear {
            bookModel.LoadRank(timeRange: newBookTime)
        }
    }
}

struct RankView_Previews: PreviewProvider {
    static var previews: some View {
        RankView()
    }
}
