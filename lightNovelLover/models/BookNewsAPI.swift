//
//  BookNewsAPI.swift
//  lightNovelLover
//
//  Created by Shiroha on 2021/12/25.
//

import Foundation
import Kanna
import Alamofire

class BookNewsAPI {
    func GetBookNews(completion: @escaping ([News]) -> Void){
        let urlString = "https://ln-news.com/articles/search?query=&category=latest"
        if let url = URL(string: urlString) {
            URLSession.shared.dataTask(with: url) { data, response, error in
                if let data = data {
                    do {
                        let decoder = JSONDecoder()
                        decoder.dateDecodingStrategy = .iso8601
                        let searchResponse = try decoder.decode(BookNews.self,from: data)
                        completion(searchResponse.articles)
                    } catch {
                        print(error)
                    }
                } else {
                // show error
                }
            }.resume()
        }
    }
    
    func GetBookNewsDetail(html: String, completion: @escaping (String) -> Void) {
        let url = "https://ln-news.com" + html
        AF.request(url, encoding: URLEncoding.default).responseString(encoding: String.Encoding.utf8) { response in
            let re = response.value ?? "Nope"
            if let doc = try? HTML(html: re, encoding: .utf8) {
                for data in doc.xpath("//*[@id=\"main-view-inner\"]/div[1]/div/div[3]/div") {
//                    for link in doc.xpath("//*[@id=\"main-view-inner\"]/div[1]/div/div[3]/div/p[@class='mce-center']/img") {
//                        print(link["src"])
//                    }
                    completion(data.text ?? "N/A")
                }
            }
        }
    }
}
