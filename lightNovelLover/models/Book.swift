//
//  Book.swift
//  lightNovelLover
//
//  Created by Shiroha on 2021/12/16.
//

import Foundation

struct Book: Identifiable {
    let id: UUID = UUID()
    var name: String = "N/A"
    var series: String = "N/A"
    var ep: String = "N/A"
    var author: String = "N/A"
    var illustrator: String = "N/A"
    var publisher: String = "N/A"
    var publishedDate: String = "N/A"
    var imageLink: String = "N/A"
    var bwLink: String = "N/A"
    var amLink: String = "N/A"
    var rank: Int = -1
    var description = "N/A"
    var ncode_link = "N/A"
    var ncode_data = "N/A"
    var isFavorite = -1
    var bought = -1
    var reading = -1
    var progress = ""
}
