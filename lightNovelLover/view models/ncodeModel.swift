//
//  ncodeModel.swift
//  lightNovelLover
//
//  Created by Shiroha on 2021/12/25.
//

import Foundation

class ncodeModel: ObservableObject {
    @Published var ncodeList: [ncode] = []
    @Published var ncodeIndex: [(index: String, link: String)] = []
    @Published var ncodeIndexData = ""
    let ncodeapi = ncodeAPI()
    let dispatchQueue = DispatchQueue(label: "QueueIdentification", qos: .background)
    func LoadncodeList() {
        dispatchQueue.async{
            self.ncodeapi.GetncodeList { re in
                self.ncodeapi.ParsencodeRank(html: re) { response in
                    self.ncodeList = response
                }
            }
        }
    }
    
    func LoadIndex(url: String) {
        self.ncodeapi.ParseIndex(html: url) {re in
            self.ncodeIndex = re
        }
    }
    func LoadIndexData(url: String) {
        self.ncodeapi.ParseIndexData(html: "https://ncode.syosetu.com" + url) {re in
            self.ncodeIndexData = re
        }
    }
}
