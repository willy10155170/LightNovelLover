//
//  ncodeView.swift
//  lightNovelLover
//
//  Created by Shiroha on 2021/12/25.
//

import SwiftUI

struct ncodeView: View {
    @EnvironmentObject var networkStatus: NetworkStatus
    @State private var showAlert = false
    @StateObject var ncode = ncodeModel()
    var body: some View {
        NavigationView {
            VStack {
//                Picker(selection: $newBookTime) {
//                    Text("本週").tag(0)
//                    Text("下週").tag(1)
//                } label: {
//                    Text("選擇時間")
//                }
//                .onChange(of: newBookTime) { tag in
//                    bookInfoModel.NewBookList = []
//                    bookInfoModel.LoadNewBook(timeRange: newBookTime)
//                }
//                .pickerStyle(.segmented)
                List{
                    ForEach(ncode.ncodeList){ nc in
                        NavigationLink {
                            ncodeIndexView(nc: nc)
                        } label: {
                            ncodeRowView(nc: nc)
                        }
                    }
                }
                .overlay {
                    if ncode.ncodeList.isEmpty && networkStatus.isConnected {
                        ProgressView()
                    }
                    else if ncode.ncodeList.isEmpty && !networkStatus.isConnected {
                        Text("試著打開你的網路看看？")
                    }
                }
                .refreshable {
                    ncode.ncodeList = []
                    showAlert = ncode.ncodeList.isEmpty && !networkStatus.isConnected
                    
                    if networkStatus.isConnected {
                        ncode.LoadncodeList()
                    }
                }
            }
            .navigationTitle("小説家になろう")
        }
        .onAppear {
            if networkStatus.isConnected {
                ncode.LoadncodeList()
            }
            showAlert = ncode.ncodeList.isEmpty && !networkStatus.isConnected
        }
        .alert("沒有網路連線", isPresented: $showAlert, actions: {
            Button("OK") { }
        })
    }
}

struct ncodeView_Previews: PreviewProvider {
    static var previews: some View {
        ncodeView()
    }
}
