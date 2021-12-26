//
//  ncodeIndexView.swift
//  lightNovelLover
//
//  Created by Shiroha on 2021/12/26.
//

import SwiftUI

struct ncodeIndexView: View {
    @StateObject var ncModel = ncodeModel()
    let nc: ncode
    var body: some View {
        GeometryReader { geometry in
            ScrollView(showsIndicators: false) {
                Text(nc.name + "\n\n")
                    .font(.system(size: 25))
                    .fontWeight(.heavy)
                    .frame(width: geometry.size.width - 20)
                
                if !ncModel.ncodeIndex.isEmpty {
                    VStack(alignment: .leading) {
                        ForEach(0...ncModel.ncodeIndex.count - 1, id: \.self) { i in
                            NavigationLink {
                                ncodeReadingView(link: ncModel.ncodeIndex[i].link)
                            } label: {
                                Text(ncModel.ncodeIndex[i].index + "\n\n")
                            }
                        }
                    }
                }
            }
        }
        .overlay {
            if(ncModel.ncodeIndex.isEmpty) {
                ProgressView()
            }
        }
        .onAppear {
            ncModel.LoadIndex(url: nc.ncode_link)
        }
    }
}

struct ncodeIndexView_Previews: PreviewProvider {
    static var previews: some View {
        ncodeIndexView(nc: ncode())
    }
}
