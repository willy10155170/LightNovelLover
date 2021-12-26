//
//  ncodeReadingView.swift
//  lightNovelLover
//
//  Created by Shiroha on 2021/12/26.
//

import SwiftUI

struct ncodeReadingView: View {
    @StateObject var ncModel = ncodeModel()
    let link: String
    var body: some View {
        GeometryReader { geometry in
            ScrollView(.vertical, showsIndicators: false){
                VStack(alignment: .center){
                    Text(ncModel.ncodeIndexData)
                }
            }
        }
            .onAppear{
                ncModel.LoadIndexData(url: link)
            }
    }
}

struct ncodeReadingView_Previews: PreviewProvider {
    static var previews: some View {
        ncodeReadingView(link: "")
    }
}
