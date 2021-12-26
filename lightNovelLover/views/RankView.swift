//
//  RankView.swift
//  lightNovelLover
//
//  Created by Shiroha on 2021/12/16.
//

import SwiftUI

struct RankView: View {
    @EnvironmentObject var networkStatus: NetworkStatus
    @StateObject var bookInfoModel = BookInfoModel()
    @State private var newBookTime = 0
    @State private var showAlert = false
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
                    bookInfoModel.RankList = []
                    if networkStatus.isConnected {
                        bookInfoModel.LoadRank(timeRange: newBookTime)
                    }
                }
                .pickerStyle(.segmented)
                List{
                    ForEach(bookInfoModel.RankList){ book in
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
                    if bookInfoModel.RankList.isEmpty && networkStatus.isConnected {
                        ProgressView()
                    }
                    else if bookInfoModel.NewBookList.isEmpty && !networkStatus.isConnected {
                        Text("試著打開你的網路看看？")
                    }
                }
                .refreshable {
                    bookInfoModel.RankList = []
                    showAlert = bookInfoModel.RankList.isEmpty && !networkStatus.isConnected
                    
                    if networkStatus.isConnected {
                        bookInfoModel.LoadRank(timeRange: newBookTime)
                    }
                }
            }
            .navigationTitle("銷售排行榜")
        }
        .onAppear {
            if networkStatus.isConnected {
                bookInfoModel.LoadRank(timeRange: newBookTime)
            }
            showAlert = bookInfoModel.RankList.isEmpty && !networkStatus.isConnected
        }
        .alert("沒有網路連線", isPresented: $showAlert, actions: {
            Button("OK") { }
        })
    }
}

struct RankView_Previews: PreviewProvider {
    static var previews: some View {
        RankView()
    }
}
