//
//  ncodeRowView.swift
//  lightNovelLover
//
//  Created by Shiroha on 2021/12/25.
//

import SwiftUI

struct ncodeRowView: View {
    let nc: ncode
    var body: some View {
        VStack(alignment: .leading) {
            Text(nc.name)
                .font(.system(size: 18))
                .fontWeight(.heavy)
                .foregroundColor(.blue)
                .lineLimit(2)
            Text("作者: " + nc.author)
            Text(nc.update)
            Text("總字數: " + nc.total_text)
            //Text("出版日: " + nc.description)
        }
    }
}

struct ncodeRowView_Previews: PreviewProvider {
    static var previews: some View {
        ncodeRowView(nc: ncode())
    }
}
