//
//  BookNewsModel.swift
//  lightNovelLover
//
//  Created by Shiroha on 2021/12/25.
//

import Foundation
import SwiftUI

class BookNewsModel: ObservableObject {
    @Published var NewsList: [News] = []
    @Published var NewsDetail = ""
    let newsapi = BookNewsAPI()
    let dispatchQueue = DispatchQueue(label: "QueueIdentification", qos: .background)
    func loadNews() {
        dispatchQueue.async{
            self.newsapi.GetBookNews() { response in
                self.NewsList = response
            }
        }
    }
    
    func LoadNewsDetail(html: String) {
        self.newsapi.GetBookNewsDetail(html: html) { response in
            self.NewsDetail = response
        }
    }
}
