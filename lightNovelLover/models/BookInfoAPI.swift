//
//  BookInfoAPI.swift
//  lightNovelLover
//
//  Created by Shiroha on 2021/12/25.
//

import Foundation
import Alamofire
import Kanna

class BookInfoAPI {
    func ParseWeekHTML(html: String, completion: @escaping ([Book]) -> Void) {
        var response: [Book] = []
        if let doc = try? HTML(html: html, encoding: .utf8) {
            for i in 1...70 {
                for title in doc.xpath("//*[@id=\"base\"]/div[2]/h2[\(i)]") {
                    // /html/body/div[2]/div[2]/h2[1]
                    // /html/body/div[2]/div[2]/h2[2]
                    let date = title.text?.components(separatedBy: "　")[0]
                    let publisher = title.text?.components(separatedBy: "　")[1]
                    var book_name: [String] = []
                    var author_name: [String] = []
                    var image_link: [String] = []
                    var bw_link: [String] = []
                    var am_link: [String] = []
                    for j in 1...50 {
                        var temp_book_name = ""
                        var temp_author_name = ""
                        var temp_image_link = ""
                        var temp_bw_link = ""
                        var temp_am_link = ""
                        for book in doc.xpath("//*[@id=\"base\"]/div[2]/table[\(i)]/tr[\(j)]/td[1]"){
                            //print(book.text)
                            temp_book_name = book.text ?? "N/A"
                            //book_name.append(book.text ?? "N/A")
                        }
                        for author in doc.xpath("//*[@id=\"base\"]/div[2]/table[\(i)]/tr[\(j)]/td[2]/text()"){
                            //print(author.text)
                            temp_author_name = author.text ?? "N/A"
                            //author_name.append(author.text ?? "N/A")
                        }
                        for img_link in doc.css("#base > div.main > div:nth-child(\(5 + 3 * (i - 1))) > ul > li:nth-child(\(j)) > a > div > img") {
                            //print(img_link["data-echo"])
                            temp_image_link = img_link["data-echo"] ?? "N/A"
                            //image_link.append(img_link["data-echo"] ?? "")
                        }
                        for shop_link in doc.xpath("//*[@id=\"base\"]/div[2]/table[\(i)]/tr[\(j)]/td[2]/div[1]/a") {
                            temp_bw_link = shop_link["href"] ?? "N/A"
                            //print(shop_link["href"])
                        }
                        for shop_link in doc.xpath("//*[@id=\"base\"]/div[2]/table[\(i)]/tr[\(j)]/td[2]/div[2]/a") {
                            temp_am_link = shop_link["href"] ?? "N/A"
                            //print(shop_link["href"])
                        }
                        if(temp_book_name == "") {
                            break
                        }
                        book_name.append(temp_book_name)
                        author_name.append(temp_author_name)
                        image_link.append(temp_image_link)
                        bw_link.append(temp_bw_link)
                        am_link.append(temp_am_link)
                    }
                    for j in 0...book_name.count - 1 {
                        response.append(Book(name: book_name[j], author: author_name[j], publisher: publisher ?? "N/A", publishedDate: date ?? "N/A", imageLink: image_link[j], bwLink: bw_link[j], amLink: am_link[j]))
                    }
                }
            }
        }
        for i in 0...response.count - 1 {
            AF.request(response[i].amLink, encoding: URLEncoding.default).responseString(encoding: String.Encoding.utf8) { res in
                let re = res.value ?? "N/A"
                if let doc = try? HTML(html: re, encoding: .utf8) {
                    for ill in doc.xpath("//*[@id=\"bylineInfo\"]/span[2]/a") {
                        response[i].illustrator = ill.text ?? "N/A"
                    }
                    
                    for des in doc.xpath("//*[@id=\"bookDescription_feature_div\"]/div/div[1]") {
                        var temp = des.text?.replacingOccurrences(of: "。 ", with: "。\n\n")
                        temp = temp?.replacingOccurrences(of: "! ", with: "!\n\n")
                        temp = temp?.replacingOccurrences(of: " ", with: "")
                        response[i].description = temp ?? "N/A"
                    }
                    
                    
                }
                completion(response)
            }
        }
        
    }
    
    func ParseMonthHTML(html: String, completion: @escaping ([Book]) -> Void) {
        var response: [Book] = []
        if let doc = try? HTML(html: html, encoding: .utf8) {
            for i in 1...70 {
                for title in doc.xpath("/html/body/div[2]/div[2]/h2[\(i)]") {
                    let date = title.text?.components(separatedBy: "　")[0]
                    let publisher = title.text?.components(separatedBy: "　")[1]
                    var book_name: [String] = []
                    var author_name: [String] = []
                    var image_link: [String] = []
                    for j in 1...50 {
                        var temp_book_name = ""
                        var temp_author_name = ""
                        var temp_image_link = ""
                        for book in doc.xpath("/html/body/div[2]/div[2]/table[\(i)]/tr[\(j)]/td[1]"){
                            temp_book_name = book.text ?? "N/A"
                            //book_name.append(book.text ?? "N/A")
                        }
                        for author in doc.xpath("/html/body/div[2]/div[2]/table[\(i)]/tr[\(j)]/td[2]/text()"){
                            //print(author.text)
                            temp_author_name = author.text ?? "N/A"
                            //author_name.append(author.text ?? "N/A")
                        }
                        
                        // 2020 06 up: body > div.body > div.main > div:nth-child(\(4 + 3 * (i - 1))) > ul > li:nth-child(\(j)) > a > div > img
                        // 2020 05 down: body > div.body > div.main > div:nth-child(\(4 + 3 * (i - 1))) > a:nth-child(\(j)) > img

                        for img_link in doc.css("body > div.body > div.main > div:nth-child(\(4 + 3 * (i - 1))) > ul > li:nth-child(\(j)) > a > div > img") {
                            temp_image_link = img_link["data-echo"] ?? "N/A"
                            //print(img_link["data-echo"])
                            //image_link.append(img_link["data-echo"] ?? "")
                        }
                        if(temp_book_name == "") {
                            break
                        }
                        book_name.append(temp_book_name)
                        author_name.append(temp_author_name)
                        image_link.append(temp_image_link)
                    }
                    
                    //print(i, book_name.count, author_name.count)
                    
                    for j in 0...book_name.count - 1 {
                        response.append(Book(name: book_name[j], author: author_name[j], publisher: publisher ?? "N/A", publishedDate: date ?? "N/A", imageLink: image_link[j]))
                    }
                }
            }
        }
        completion(response)
    }
    
    func GetNewBook(timeRange: Int, completion: @escaping (String) -> Void) {
        var url = ""
        if timeRange == 0 {
            url = "https://lightnovel.jp/publicationdate"
        }
        else if timeRange == 1 {
            url = "https://lightnovel.jp/publicationdate/next"
        }
        AF.request(url, encoding: URLEncoding.default).responseString(encoding: String.Encoding.utf8) { response in
            let re = response.value ?? "Nope"
            //print(re)
            completion(re)
        }
    }
    
    func ParseBW(html: String, completion: @escaping ([Book]) -> Void) {
        var response: [Book] = []
        if let doc = try? HTML(html: html, encoding: .utf8) {
            var book_name: [String] = []
            var author_name: [String] = []
            var illustrator_name: [String] = []
            var image_link: [String] = []
            var bw_link: [String] = []
            for i in 1...26 {
                for name in doc.xpath("//*[@id=\"rankingContentsInner\"]/div/section[\(i)]/div/div[2]/h3/a") {
                    book_name.append(name.text ?? "N/A")
                }
                
                for j in 1...3 {
                    var temp_name = ""
                    for author in doc.xpath("//*[@id=\"rankingContentsInner\"]/div[1]/section[\(i)]/div/div[2]/dl[1]/dd[\(j)]/a") {
                        temp_name = author.text ?? "N/A"
                        //author_name.append(author.text ?? "N/A")
                    }
                    if j == 1 {
                        author_name.append(temp_name)
                    }
                    else if j == 2 {
                        if temp_name == "" {
                            illustrator_name.append(author_name[i - 1])
                        }
                        else {
                            illustrator_name.append(temp_name)
                        }
                    }
                }
                
                for img_link in doc.css("#rankingContentsInner > div:nth-child(1) > section:nth-child(\(i)) > div > div.detailLeftSec.rankingLeftSec > p.detailbookImg > a:nth-child(1) > img") {
                    image_link.append(img_link["src"] ?? "N/A")
                }
                
                for shop_link in doc.css("#rankingContentsInner > div:nth-child(1) > section:nth-child(\(i)) > div > div.rankingRightSec > h3 > a") {
                    bw_link.append(shop_link["href"] ?? "N/A")
                }
                
            }
            for i in 0...book_name.count - 1 {
                response.append(Book(name: book_name[i], author: author_name[i], illustrator: illustrator_name[i], imageLink: image_link[i], bwLink: bw_link[i], rank: i + 1))
            }
        }
        for i in 0...response.count - 1 {
            AF.request(response[i].bwLink, encoding: URLEncoding.default).responseString(encoding: String.Encoding.utf8) { res in
                let re = res.value ?? "Nope"
                if let doc = try? HTML(html: re, encoding: .utf8) {
                    for date in doc.xpath("//*[@id=\"information-section\"]/div[1]/div[1]/dl/dd[7]") {
                        response[i].publishedDate = date.text ?? "N/A"
                    }
                    for publisher in doc.xpath("//*[@id=\"information-section\"]/div[1]/div[1]/dl/dd[3]/a") {
                        response[i].publisher = publisher.text ?? "N/A"
                    }
                    for series in doc.xpath("//*[@id=\"information-section\"]/div[1]/div[1]/dl/dd[1]/a") {
                        response[i].series = series.text ?? "N/A"
                    }
                    for des in doc.xpath("//*[@id=\"js-summary-collapse-main-product\"]/p[2]") {
                        var temp = des.text?.replacingOccurrences(of: "\n                               ", with: "")
                        temp = temp?.replacingOccurrences(of: "                            ", with: "")
                        temp = temp?.replacingOccurrences(of: "\n", with: "\n\n")
                        response[i].description = temp ?? "N/A"
                    }
                    for img_link in doc.css("#js-top-block > div > div.p-main__body > div.p-main__left > div.p-main__thumb > div.m-thumb > a > img") {
                        response[i].imageLink = img_link["data-original"] ?? response[i].imageLink
                    }
                }
                completion(response)
            }
        }
    }
    
    func GetBookRank(timeRange: Int, completion: @escaping (String) -> Void) {
        var url = "https://bookwalker.jp/rank/ct3/?mode=month"
        if timeRange == 0 {
            url = "https://bookwalker.jp/rank/ct3/?mode=daily"
        }
        else if timeRange == 1 {
            url = "https://bookwalker.jp/rank/ct3/?mode=weekly"
        }
        else if timeRange == 2 {
            url = "https://bookwalker.jp/rank/ct3/?mode=month"
        }
        AF.request(url, encoding: URLEncoding.default).responseString(encoding: String.Encoding.utf8) { response in
            let re = response.value ?? "Nope"
            completion(re)
        }
    }
}
