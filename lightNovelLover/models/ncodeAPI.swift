//
//  ncodeAPI.swift
//  lightNovelLover
//
//  Created by Shiroha on 2021/12/25.
//

import Foundation
import Kanna
import Alamofire

class ncodeAPI {
    func GetncodeList (completion: @escaping (String) -> Void) {
        var url = "https://yomou.syosetu.com/rank/list/type/weekly_total/"
        AF.request(url, encoding: URLEncoding.default).responseString(encoding: String.Encoding.utf8) { response in
            let re = response.value ?? "Nope"
            completion(re)
        }
    }
    
    func ParsencodeRank(html: String, completion: @escaping ([ncode]) -> Void) {
        if let doc = try? HTML(html: html, encoding: .utf8) {
            var book_name: [String] = []
            var author_name: [String] = []
            var ncode_link: [String] = []
            var description: [String] = []
            var update_time: [String] = []
            var total_text: [String] = []
            var response: [ncode] = []
            for i in 1...50 {
                for name in doc.xpath("//*[@id=\"best\(i)\"]") {
                    book_name.append(name.text ?? "N/A")
                    ncode_link.append(name["href"] ?? "N/A")
                }
                
                for author in doc.xpath("//*[@id=\"main_rank\"]/div[1]/div[3]/div[@class='ranking_list']/table/tr[1]/td/a[2]") {
                    author_name.append(author.text ?? "N/A")
                }
                
                for des in doc.xpath("//*[@id=\"main_rank\"]/div[1]/div[3]/div[@class='ranking_list']/table/tr[2]/td[2]") {
                    description.append(des.text ?? "N/A")
                }
                
                for update in doc.xpath("//*[@id=\"main_rank\"]/div[1]/div[3]/div[@class='ranking_list']/table/tr[5]/td") {
                    update_time.append(update.text?.components(separatedBy: "\n")[1] ?? "N/A")
                    total_text.append(update.text?.components(separatedBy: "\n")[2] ?? "N/A")
                }
            }
            for i in 0...49 {
                response.append(ncode(name: book_name[i], author: author_name[i], update: update_time[i], total_text: total_text[i], rank: i + 1, description: description[i], ncode_link: ncode_link[i]))
            }
            completion(response)
        }
    }
    
    func ParseIndex(html: String, completion: @escaping ([(index: String, link: String)]) -> Void) {
        var re_nc: [(index: String, link: String)] = []
        AF.request(html, encoding: URLEncoding.default).responseString(encoding: String.Encoding.utf8) { response in
            let re = response.value ?? "N/A"
            var count = 0
            if let doc = try? HTML(html: re, encoding: .utf8) {
                for title in doc.xpath("//*[@id=\"novel_color\"]/div[4]/dl/dd/a") {
                    let index = title.text ?? "N/A"
                    re_nc.append((index: index, link: title["href"] ?? "N/A"))
                }
                count += 1
            }
            completion(re_nc)
        }
    }
    
    func ParseIndexData(html: String, completion: @escaping (String) -> Void) {
        AF.request(html, encoding: URLEncoding.default).responseString(encoding: String.Encoding.utf8) { response in
            let re = response.value ?? "N/A"
            if let doc = try? HTML(html: re, encoding: .utf8) {
                for data in doc.xpath("//*[@id=\"novel_honbun\"]") {
                    completion(data.text ?? "N/A")
                }
            }
        }
    }
}
