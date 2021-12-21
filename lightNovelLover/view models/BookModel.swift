//
//  BookModel.swift
//  lightNovelLover
//
//  Created by Shiroha on 2021/12/16.
//

import Foundation
import SwiftUI

class BookModel: ObservableObject {
    @Published var NewBookList: [Book] = []
    @Published var RankList: [Book] = []
    let bookapi = BookAPI()
    func LoadNewBook(timeRange: Int) {
        bookapi.GetNewBook(timeRange: timeRange) { re in
            self.bookapi.ParseWeekHTML(html: re) { response in
                self.NewBookList = response
            }
        }
    }
    
    func LoadRank(timeRange: Int) {
        bookapi.GetBookRank(timeRange: timeRange) { re in
            self.bookapi.ParseBW(html: re) { response in
                //print(response)
                self.RankList = response
            }
        }
    }
}
