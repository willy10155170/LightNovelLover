//
//  BookInfoModel.swift
//  lightNovelLover
//
//  Created by Shiroha on 2021/12/25.
//

import Foundation
import SwiftUI

class BookInfoModel: ObservableObject {
    @Published var NewBookList: [Book] = []
    @Published var RankList: [Book] = []
    let bookapi = BookInfoAPI()
    let dispatchQueue = DispatchQueue(label: "QueueIdentification", qos: .background)
    func LoadNewBook(timeRange: Int) {
        self.bookapi.GetNewBook(timeRange: timeRange) { re in
            self.bookapi.ParseWeekHTML(html: re) { response in
                self.NewBookList = response
            }
        }
    }
    
    func LoadRank(timeRange: Int) {
        dispatchQueue.async{
            self.bookapi.GetBookRank(timeRange: timeRange) { re in
                self.bookapi.ParseBW(html: re) { response in
                    //print(response)
                    self.RankList = response
                }
            }
        }
    }
    
    
}
