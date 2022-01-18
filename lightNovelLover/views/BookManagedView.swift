//
//  BookManagedView.swift
//  lightNovelLover
//
//  Created by Shiroha on 2022/1/6.
//

import SwiftUI

struct BookManagedView: View {
//    @Environment(\.managedObjectContext) private var viewContext
//    @FetchRequest(
//    sortDescriptors: [NSSortDescriptor(keyPath:
//    \LocalBook.name, ascending: true)],
//    animation: .default)
//    private var items: FetchedResults<LocalBook>
    @EnvironmentObject var bookDataModel: BookDataModel
    @State private var showSecondPage = false
    @State private var showAlert = false
    @State var inputByhtml = false
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading) {
                List {
                    Button("新增一本書") {
                    //showSecondPage = true
                        showAlert = true
                    }
                    .alert("請選擇新增方式", isPresented: $showAlert, actions: {
                        Button("自行輸入") {
                            showSecondPage = true
                            inputByhtml = false
                        }
                        Button("透過網址擷取") {
                            showSecondPage = true
                            inputByhtml = true
                        }
                    })
                    .sheet(isPresented: $showSecondPage) {
                        addBookView(showSecondPage: $showSecondPage, inputByhtml: $inputByhtml)
                    }
                    NavigationLink {
                        FavoriteView(showingStatus: 0)
                    } label: {
                        Text("我的最愛")
                    }
                    NavigationLink {
                        FavoriteView(showingStatus: 1)
                    } label: {
                        Text("購買清單")
                    }
                    NavigationLink {
                        FavoriteView(showingStatus: 2)
                    } label: {
                        Text("閱讀佇列")
                    }
                }
            }
            .navigationTitle("我的書庫")
        }
    }
}

struct BookManagedView_Previews: PreviewProvider {
    static var previews: some View {
        BookManagedView()
    }
}
