//
//  FavoriteView.swift
//  lightNovelLover
//
//  Created by Shiroha on 2022/1/7.
//

import SwiftUI

struct FavoriteView: View {
    @EnvironmentObject var bookDataModel: BookDataModel
    @State private var searchText = ""
    @State private var shareSheetShowing = false
    let showingStatus: Int
    var body: some View {
        VStack {
            List {
                ForEach(bookDataModel.saveBooks) { book in
                    NavigationLink {
//                        BookDetailView(book: makeBook(book: book))
                        ManagedDetailView(book: book, imageName: book.id?.uuidString ?? "", photoCounting: Int(book.photosNumber))
                    } label: {
                        //BookRowView(book: makeBook(book: book))
                        ManagedRowView(book: book, shareSheetShowing: $shareSheetShowing)
//                            .onLongPressGesture {
//                                shareAction(book: book)
//                            }
                    }
                }
                .onDelete(perform: bookDataModel.deleteBook)
                .onMove(perform: bookDataModel.moveBook)
            }
            .searchable(text: $searchText)
            .onChange(of: searchText) { newValue in
                bookDataModel.searchBook(keyWord: newValue)
            }
            .toolbar {
                EditButton()
            }
        }
        .onAppear {
            if showingStatus == 0 {
                bookDataModel.showingStatus = 0
                bookDataModel.getFavoriteBooks()
            }
            else if showingStatus == 1 {
                bookDataModel.showingStatus = 1
                bookDataModel.getBuyingQueue()
            }
            else if showingStatus == 2 {
                bookDataModel.showingStatus = 2
                bookDataModel.getReadingQueue()
            }
            print(bookDataModel.showingStatus)
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

struct FavoriteView_Previews: PreviewProvider {
    static var previews: some View {
        FavoriteView(showingStatus: 0)
    }
}

func makeBook(book: LocalBook) -> Book {
    var re = Book()
    re.name = book.name ?? "N/A"
    re.author = book.author ?? "N/A"
    re.rank = Int(book.rank)
    re.publishedDate = book.publishedDate ?? "N/A"
    re.publisher = book.publisher ?? "N/A"
    re.illustrator = book.illustrator ?? "N/A"
    re.imageLink = book.imageLink ?? "N/A"
    re.bwLink = book.bwLink ?? "N/A"
    re.amLink = book.amLink ?? "N/A"
    re.description = book.des ?? "N/A"
    
    return re
}
