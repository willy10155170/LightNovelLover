//
//  ManagedRowView.swift
//  lightNovelLover
//
//  Created by Shiroha on 2022/1/16.
//

import SwiftUI

struct ManagedRowView: View {
    let book: LocalBook
    @Binding var shareSheetShowing: Bool
    var body: some View {
        HStack(alignment: .top) {
            let documentsDirectory =
            FileManager.default.urls(for: .documentDirectory,
            in: .userDomainMask).first!
            let name = book.id?.uuidString ?? ""
            let url = documentsDirectory.appendingPathComponent(name + "0")
            if let data = try? Data(contentsOf: url),
            let uiImage = UIImage(data: data) {
                Image(uiImage: uiImage)
                    .resizable()
                    .scaledToFill()
                    .onLongPressGesture {
                        shareAction(book: book)
                    }
            }
            Spacer()
            Spacer()
            VStack(alignment: .leading) {
                Text(book.name ?? "N/A")
                    .font(.system(size: 18))
                    .fontWeight(.heavy)
                    .foregroundColor(.blue)
                    .lineLimit(2)
                Text("書架： " + book.bookshelf!)
                Text("進度： " + progressTrans(status: Int(book.progress)))
                Text("購買狀況： " + boughtTrans(status: Int(book.bought)))
            }
        }
    }
    
    func shareAction (book: LocalBook) {
        var items: [Any] = []
        let documentsDirectory =
        FileManager.default.urls(for: .documentDirectory,
        in: .userDomainMask).first!
        let url = documentsDirectory.appendingPathComponent(book.id?.uuidString ?? "")
        if let data = try? Data(contentsOf: url),
        let uiImage = UIImage(data: data) {
            items.append(uiImage)
        }
        items.append(book.name)
        shareSheetShowing.toggle()
        let controller = UIActivityViewController(activityItems: items, applicationActivities: nil)
        UIApplication.shared.windows.first?.rootViewController?.present(controller, animated: true, completion: nil)
    }
}

struct ManagedRowView_Previews: PreviewProvider {
    static var previews: some View {
        ManagedRowView(book: LocalBook(), shareSheetShowing: .constant(false))
    }
}

func progressTrans(status: Int) -> String {
    if status == 0 {
        return "未讀"
    }
    else if status == 1 {
        return "閱讀中"
    }
    else {
        return "已讀"
    }
}

func boughtTrans(status: Int) -> String {
    if status == 0 {
        return "未購入"
    }
    else if status == 1 {
        return "尚未拿到"
    }
    else {
        return "已購入"
    }
}
