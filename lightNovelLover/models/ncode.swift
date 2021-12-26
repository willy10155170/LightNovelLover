//
//  ncode.swift
//  lightNovelLover
//
//  Created by Shiroha on 2021/12/25.
//

import Foundation

struct ncode: Identifiable {
    let id: UUID = UUID()
    var name: String = "N/A"
    var author: String = "N/A"
    var update = "N/A"
    var total_text = "N/A"
    var rank: Int = -1
    var description = "N/A"
    var ncode_link = "N/A"
    var ncode_data = "N/A"
    var ncode_index: [String:String] = [:]
}
