//
//  BookNewsView.swift
//  lightNovelLover
//
//  Created by Shiroha on 2021/12/25.
//

import SwiftUI

struct BookNewsView: View {
    @EnvironmentObject var networkStatus: NetworkStatus
    @State private var showAlert = false
    @StateObject var newsmodel = BookNewsModel()
    var body: some View {
        NavigationView {
            VStack {
                List{
                    ForEach(newsmodel.NewsList){ news in
                        NavigationLink {
                            BookNewsDetailView(news: news)
                        } label: {
                            BookNewsRowView(news: news)
                        }
                    }
                }
                .overlay {
                    if newsmodel.NewsList.isEmpty && networkStatus.isConnected {
                        ProgressView()
                    }
                    else if newsmodel.NewsList.isEmpty && !networkStatus.isConnected {
                        Text("試著打開你的網路看看？")
                    }
                }
                .refreshable {
                    newsmodel.NewsList = []
                    showAlert = newsmodel.NewsList.isEmpty && !networkStatus.isConnected
                    
                    if networkStatus.isConnected {
                        newsmodel.loadNews()
                    }
                }
            }
            .navigationTitle("最新消息")
        }
        .onAppear {
            if networkStatus.isConnected {
                newsmodel.loadNews()
            }
            showAlert = newsmodel.NewsList.isEmpty && !networkStatus.isConnected
        }
        .alert("沒有網路連線", isPresented: $showAlert, actions: {
            Button("OK") { }
        })
    }
}

struct BookNewsView_Previews: PreviewProvider {
    static var previews: some View {
        BookNewsView()
    }
}
