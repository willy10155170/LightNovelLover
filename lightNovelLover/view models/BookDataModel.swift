//
//  BookDataModel.swift
//  lightNovelLover
//
//  Created by Shiroha on 2022/1/6.
//

import Foundation
import CoreData
import SwiftUI

class BookDataModel: ObservableObject {
    let container: NSPersistentContainer
    @Published var saveBooks: [LocalBook] = []
    @Published var showingStatus = 0
    //@NSManaged public var userOrder: Int16
    
    init() {
        container = NSPersistentContainer(name:"BookData")
        container.loadPersistentStores { description, error in
            if let error = error {
                print("error \(error)")
            }
        }
        fetchBooks()
    }
    
    func fetchBooks() {
        let sort = NSSortDescriptor(key: #keyPath(LocalBook.userOrder), ascending: true)
        let fetchRequest = NSFetchRequest<LocalBook> (entityName: "LocalBook")
        fetchRequest.sortDescriptors = [sort]
        do {
            saveBooks = try container.viewContext.fetch(fetchRequest)
        } catch let error {
            print("error \(error)")
        }
    }
    
    func getFavoriteBooks() {
        sortWithFavorite()
        var temp: [LocalBook] = []
        for i in saveBooks {
            if i.favoriteRank != -1 {
                temp.append(i)
            }
        }
        saveBooks = temp
    }
    
    func getBuyingQueue() {
        sortWithBuying()
        var temp: [LocalBook] = []
        for i in saveBooks {
            if i.buyOrder != -1 {
                temp.append(i)
            }
        }
        saveBooks = temp
    }
    
    func getReadingQueue() {
        sortWithReading()
        var temp: [LocalBook] = []
        for i in saveBooks {
            if i.readOrder != -1 {
                temp.append(i)
            }
        }
        saveBooks = temp
    }
    
    func addBook(book: Book) {
        let newBook = LocalBook(context: container.viewContext)
        newBook.name = book.name
        newBook.series = book.series
        newBook.des = book.description
        newBook.amLink = book.amLink
        newBook.author = book.author
        newBook.bwLink = book.bwLink
        newBook.ep = book.ep
        newBook.imageLink = book.imageLink
        newBook.illustrator = book.illustrator
        newBook.publisher = book.publisher
        newBook.publishedDate = book.publishedDate
        newBook.rank = Int16(book.rank)
        if book.isFavorite == -1 {
            newBook.favoriteRank = -1
        }
        else {
            newBook.favoriteRank = Int16(saveBooks.count + 1)
        }
        newBook.id = UUID()
        newBook.userOrder = Int16(saveBooks.count + 1)
        newBook.bookshelf = "N/A"
        newBook.progress = 0
        if book.bought == -1 {
            newBook.buyOrder = -1
        }
        else {
            newBook.buyOrder = Int16(saveBooks.count + 1)
        }
        if book.reading == -1 {
            newBook.readOrder = -1
        }
        else {
            newBook.readOrder = Int16(saveBooks.count + 1)
        }
        newBook.photosNumber = 0
        var tempName = newBook.id?.uuidString ?? ""
        tempName += "0"
        saveImageData(url: URL(string: newBook.imageLink ?? "")!, name: tempName)
        saveData()
    }
    
    func deleteBook(offsets: IndexSet) {
        withAnimation {
            offsets.map { saveBooks[$0] }.forEach(container.viewContext.delete)
            saveData()
        }
    }
    
    func moveBook(source: IndexSet, destination: Int) {
        var revisedBooks: [LocalBook] = saveBooks.map{$0}
        revisedBooks.move(fromOffsets: source, toOffset: destination)
        if showingStatus == 0 {
            for reverseIndex in stride(from: revisedBooks.count - 1, through: 0, by: -1) {
                revisedBooks[reverseIndex].favoriteRank = Int16(reverseIndex)
            }
        }
        else if showingStatus == 1 {
            for reverseIndex in stride(from: revisedBooks.count - 1, through: 0, by: -1) {
                revisedBooks[reverseIndex].buyOrder = Int16(reverseIndex)
            }
        }
        else if showingStatus == 2 {
            for reverseIndex in stride(from: revisedBooks.count - 1, through: 0, by: -1) {
                revisedBooks[reverseIndex].readOrder = Int16(reverseIndex)
            }
        }
        saveData()
    }
    
    func saveData() {
        do {
            try container.viewContext.save()
            //fetchBooks()
            if showingStatus == 0 {
                getFavoriteBooks()
            }
            else if showingStatus == 1 {
                getBuyingQueue()
            }
            else if showingStatus == 2 {
                getReadingQueue()
            }
        } catch let error {
            print("error \(error)")
        }
    }
    
    func sortWithFavorite() {
        let sort = NSSortDescriptor(key: #keyPath(LocalBook.favoriteRank), ascending: true)
        let fetchRequest = NSFetchRequest<LocalBook> (entityName: "LocalBook")
        fetchRequest.sortDescriptors = [sort]
        do {
            saveBooks = try container.viewContext.fetch(fetchRequest)
        } catch let error {
            print("error \(error)")
        }
    }
    
    func sortWithBuying() {
        let sort = NSSortDescriptor(key: #keyPath(LocalBook.buyOrder), ascending: true)
        let fetchRequest = NSFetchRequest<LocalBook> (entityName: "LocalBook")
        fetchRequest.sortDescriptors = [sort]
        do {
            saveBooks = try container.viewContext.fetch(fetchRequest)
        } catch let error {
            print("error \(error)")
        }
    }
    
    func sortWithReading() {
        let sort = NSSortDescriptor(key: #keyPath(LocalBook.readOrder), ascending: true)
        let fetchRequest = NSFetchRequest<LocalBook> (entityName: "LocalBook")
        fetchRequest.sortDescriptors = [sort]
        do {
            saveBooks = try container.viewContext.fetch(fetchRequest)
        } catch let error {
            print("error \(error)")
        }
    }
    
    func searchBook(keyWord: String) {
        if (keyWord != ""){
            var temp: [LocalBook] = []
            for i in saveBooks {
                if i.name!.contains(keyWord) {
                    temp.append(i)
                }
            }
            saveBooks = temp
        }
        else {
            self.fetchBooks()
        }
    }
}

func saveImageData(url: URL, name: String) {
    DispatchQueue.global().async {
        if let data = try? Data(contentsOf: url) {
            let documentsDirectory =
            FileManager.default.urls(for: .documentDirectory,
            in: .userDomainMask).first!
            let url = documentsDirectory.appendingPathComponent(name)
            try? data.write(to: url)
            }
    }

}

func saveImageFromLibrary(uiimage: UIImage, name: String) {
    //let rawData = myImage.cgImage?.dataProvider?.data as Data?
    DispatchQueue.global().async {
        if let data = try? uiimage.pngData() {
            let documentsDirectory =
            FileManager.default.urls(for: .documentDirectory,
            in: .userDomainMask).first!
            let url = documentsDirectory.appendingPathComponent(name)
            try? data.write(to: url)
            }
    }

}
