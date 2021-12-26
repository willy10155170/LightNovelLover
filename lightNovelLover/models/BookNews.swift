//
//  BookNews.swift
//  lightNovelLover
//
//  Created by Shiroha on 2021/12/25.
//

import Foundation
import SwiftUI

struct BookNews: Codable {
    let articles: [News]
    let cursor: String
}

struct News: Codable, Identifiable {
    let id:UUID = UUID()
    let categories: [categories]
    let description: String
    let is_pr: Bool
    let path: String
    let thumbnail: String
    let time: String
    let title: String
}

struct categories: Codable {
    let color: String
    let name: String
}

