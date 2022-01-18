//
//  IllustrationView.swift
//  lightNovelLover
//
//  Created by Shiroha on 2022/1/18.
//

import SwiftUI

struct IllustrationView: View {
    let book: LocalBook
    @State var lastScaleValue: CGFloat = 1.0
    @State var scale: CGFloat = 1.0
    @Environment(\.presentationMode) var presentationMode
    var body: some View {
        TabView {
//            let documentsDirectory =
//            FileManager.default.urls(for: .documentDirectory,
//            in: .userDomainMask).first!
//            let url = documentsDirectory.appendingPathComponent(book.id?.uuidString ?? "")
//            if let data = try? Data(contentsOf: url),
//            let uiImage = UIImage(data: data) {
//                Image(uiImage: uiImage)
//                    .scaleEffect(scale)
//                    .gesture(MagnificationGesture().onChanged { val in
//                                let delta = val / self.lastScaleValue
//                                self.lastScaleValue = val
//                                scale = self.scale * delta
//
//                    //... anything else e.g. clamping the newScale
//                    }.onEnded { val in
//                      // without this the next gesture will be broken
//                      self.lastScaleValue = 1.0
//                    })
//            }
//            Image("test_image")
            ForEach(0..<Int(book.photosNumber) + 1) { i in
                let documentsDirectory =
                FileManager.default.urls(for: .documentDirectory,
                in: .userDomainMask).first!
                let imageName = book.id?.uuidString ?? ""
                let url = documentsDirectory.appendingPathComponent(imageName + String(i))
                if let data = try? Data(contentsOf: url),
                let uiImage = UIImage(data: data) {
                    Image(uiImage: uiImage)
                        .scaleEffect(scale)
                        .gesture(MagnificationGesture().onChanged { val in
                                    let delta = val / self.lastScaleValue
                                    self.lastScaleValue = val
                                    scale = self.scale * delta

                        //... anything else e.g. clamping the newScale
                        }.onEnded { val in
                          // without this the next gesture will be broken
                          self.lastScaleValue = 1.0
                        })
                }
            }
        }
        .tabViewStyle(.page)
        .ignoresSafeArea()
        .onTapGesture {
            self.presentationMode.wrappedValue.dismiss()
        }
    }
}

struct IllustrationView_Previews: PreviewProvider {
    static var previews: some View {
        IllustrationView(book: LocalBook())
    }
}
