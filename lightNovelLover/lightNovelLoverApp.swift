//
//  lightNovelLoverApp.swift
//  lightNovelLover
//
//  Created by Shiroha on 2021/12/16.
//

import SwiftUI

@main
struct lightNovelLoverApp: App {
    @StateObject var networkStatus = NetworkStatus()
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(networkStatus)
        }
    }
}
