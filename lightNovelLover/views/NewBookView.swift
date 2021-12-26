//
//  NewBookView.swift
//  lightNovelLover
//
//  Created by Shiroha on 2021/12/16.
//

import SwiftUI

struct NewBookView: View {
    @EnvironmentObject var networkStatus: NetworkStatus
    @StateObject var bookInfoModel = BookInfoModel()
    @State private var newBookTime = 0
    @State private var showAlert = false
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
                    bookInfoModel.NewBookList = []
                    if networkStatus.isConnected {
                        bookInfoModel.LoadNewBook(timeRange: newBookTime)
                    }
                }
                .pickerStyle(.segmented)
                List{
                    ForEach(bookInfoModel.NewBookList){ book in
                        NavigationLink {
                            BookDetailView(book: book)
                        } label: {
                            BookRowView(book: book)
                        }
                    }
                }
                .overlay {
                    if bookInfoModel.NewBookList.isEmpty && networkStatus.isConnected {
                        ProgressView()
                    }
                    else if bookInfoModel.NewBookList.isEmpty && !networkStatus.isConnected {
                        Text("試著打開你的網路看看？")
                    }
                }
                .refreshable {
                    bookInfoModel.NewBookList = []
                    showAlert = bookInfoModel.NewBookList.isEmpty && !networkStatus.isConnected

                    if networkStatus.isConnected {
                        bookInfoModel.LoadNewBook(timeRange: newBookTime)
                    }
                }
            }
            .navigationTitle("本週新書")
        }
        .onAppear {
            if networkStatus.isConnected {
                bookInfoModel.LoadNewBook(timeRange: newBookTime)
            }
            showAlert = bookInfoModel.NewBookList.isEmpty && !networkStatus.isConnected
        }
        .alert("沒有網路連線", isPresented: $showAlert, actions: {
            Button("OK") { }
        })
        
    }
}

struct NewBookView_Previews: PreviewProvider {
    static var previews: some View {
        NewBookView()
    }
}
