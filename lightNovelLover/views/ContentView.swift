//
//  ContentView.swift
//  lightNovelLover
//
//  Created by Shiroha on 2021/12/16.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            NewBookView()
                .tabItem{
                    Label("近期出版", systemImage: "house.circle")
                }
            RankView()
                .tabItem{
                    Label("熱門新書", systemImage: "house.circle")
                }
            RankView()
                .tabItem{
                    Label("閱讀清單", systemImage: "house.circle")
                }
            RankView()
                .tabItem{
                    Label("購買清單", systemImage: "house.circle")
                }
            RankView()
                .tabItem{
                    Label("書籍管理", systemImage: "house.circle")
                }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}