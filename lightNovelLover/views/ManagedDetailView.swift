//
//  ManagedDetailView.swift
//  lightNovelLover
//
//  Created by Shiroha on 2022/1/16.
//

import SwiftUI

struct ManagedDetailView: View {
    let book: LocalBook
    @State private var name = ""
    @State private var author = ""
    @State private var series = ""
    @State private var ep = ""
    @State private var illustrator = ""
    @State private var publisher = ""
    @State private var publishedDate = ""
    @State private var description = ""
    @State private var edit = 0
    @State private var shareSheetShowing = false
    @State var inputImage = false
    @State var openCameraRoll = false
    @State var imageSelected = UIImage()
    let imageName: String
    @State var photoCounting: Int
    @EnvironmentObject var bookDataModel: BookDataModel
    var body: some View {
        GeometryReader { geometry in
            VStack{
                Form {
                    Group {
                        Button(action: shareAction) {
                            Image(systemName: "square.and.arrow.up")
                                .font(.largeTitle)
                        }
                    }
                    if edit == 0 {
                        NavigationLink {
                            IllustrationView(book: book)
                                .navigationBarHidden(true)
                        } label: {
                            TabView {
//                                let documentsDirectory =
//                                FileManager.default.urls(for: .documentDirectory,
//                                in: .userDomainMask).first!
//                                let url = documentsDirectory.appendingPathComponent(book.id?.uuidString ?? "")
//                                if let data = try? Data(contentsOf: url),
//                                let uiImage = UIImage(data: data) {
//                                    Image(uiImage: uiImage)
//                                        .resizable()
//                                        .scaledToFill()
//                                }
                                ForEach(0..<photoCounting + 1) { i in
                                    //Text(imageName + String(i))
                                    let documentsDirectory =
                                    FileManager.default.urls(for: .documentDirectory,
                                    in: .userDomainMask).first!
                                    let url = documentsDirectory.appendingPathComponent(imageName + String(i))
                                    if let data = try? Data(contentsOf: url),
                                    let uiImage = UIImage(data: data) {
                                        Image(uiImage: uiImage)
                                            .resizable()
                                            .scaledToFill()
                                    }
                                }
                            }
                            .tabViewStyle(.page)
                            .frame(width: 280, height: 400)
                            .scaledToFit()
                        }
                    }
                    else if edit == 1 {
                        TabView {
                            ForEach(0..<photoCounting + 1) { i in
                                //Text(imageName + String(i))
                                let documentsDirectory =
                                FileManager.default.urls(for: .documentDirectory,
                                in: .userDomainMask).first!
                                let url = documentsDirectory.appendingPathComponent(imageName + String(i))
                                if let data = try? Data(contentsOf: url),
                                let uiImage = UIImage(data: data) {
                                    Image(uiImage: uiImage)
                                        .resizable()
                                        .scaledToFill()
                                }
                            }
                        }
                        .tabViewStyle(.page)
                        .frame(width: 280, height: 400)
                        .scaledToFit()
                        Button("新增一張照片") {
                            inputImage = true
                            openCameraRoll = true
                            book.photosNumber += 1
                            photoCounting = Int(book.photosNumber)
                        }
                    }
                    HStack{
                        Text("書名： ")
                        if edit == 1{
                            TextField(book.name ?? "N/A", text: $name)
                                .textFieldStyle(.roundedBorder)
                        }
                        else {
                            Text(book.name ?? "N/A")
                        }
                    }
                    HStack{
                        Text("作者： ")
                        if edit == 1 {
                            TextField(book.author ?? "N/A", text: $author)
                                .textFieldStyle(.roundedBorder)
                        }
                        else {
                            Text(book.author ?? "N/A")
                        }
                    }
                    HStack{
                        Text("系列： ")
                        if edit == 1 {
                            TextField(book.series ?? "N/A", text: $series)
                                .textFieldStyle(.roundedBorder)
                        }
                        else {
                            Text(book.series ?? "N/A")
                        }
                    }
                    HStack{
                        Text("集數： ")
                        if edit == 1 {
                            TextField(book.ep ?? "N/A", text: $ep)
                                .textFieldStyle(.roundedBorder)
                        }
                        else {
                            Text(book.ep ?? "N/A")
                        }
                    }
                    HStack{
                        Text("畫師： ")
                        if edit == 1 {
                            TextField(book.illustrator ?? "N/A", text: $illustrator)
                                .textFieldStyle(.roundedBorder)
                        }
                        else {
                            Text(book.illustrator ?? "N/A")
                        }
                    }
                    HStack{
                        Text("出版社： ")
                        if edit == 1 {
                            TextField(book.publisher ?? "N/A", text: $publisher)
                                .textFieldStyle(.roundedBorder)
                        }
                        else {
                            Text(book.publisher ?? "N/A")
                        }
                    }
                    HStack{
                        Text("出版日： ")
                        if edit == 1 {
                            TextField(book.publishedDate ?? "N/A", text: $publishedDate)
                                .textFieldStyle(.roundedBorder)
                        }
                        else {
                            Text(book.publishedDate ?? "N/A")
                        }
                    }
                    Group {
                        Text("簡介：")
                        if edit == 1 {
                            TextEditor(text: $description)
                                .border(.blue, width: 2)
                        }
                        else {
                            Text(book.des ?? "N/A")
                        }
                    }
                }
                .toolbar {
                    if edit == 1 {
                        Button("Save") {
                            edit = 0
                            book.name = name
                            book.author = author
                            book.series = series
                            book.ep = ep
                            book.illustrator = illustrator
                            book.publisher = publisher
                            book.publishedDate = publishedDate
                            book.des = description
                            bookDataModel.saveData()
                        }
                    }
                    else {
                        Button("Edit") {
                            edit = 1
                        }
                    }
                }
            }
        }
        .onAppear {
            name = book.name ?? "N/A"
            author = book.author ?? "N/A"
            series = book.series ?? "N/A"
            ep = book.ep ?? "N/A"
            illustrator = book.illustrator ?? "N/A"
            publisher = book.publisher ?? "N/A"
            publishedDate = book.publishedDate ?? "N/A"
            description = book.des  ?? "N/A"
        }
        .sheet(isPresented: $openCameraRoll) {
            ImagePicker(imageName: imageName + String(book.photosNumber), selectedImage: $imageSelected, sourceType: .photoLibrary)
        }
    }
    func shareAction () {
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

struct ManagedDetailView_Previews: PreviewProvider {
    static var previews: some View {
        ManagedDetailView(book: LocalBook(), imageName: "", photoCounting: 0)
    }
}

