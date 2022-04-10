//
//  WordmeApp.swift
//  Wordme
//
//  Created by Baek, Songjoon (NIH/NCI) [E] on 4/10/22.
//

import SwiftUI

@main
struct WordmeApp: App {
    @StateObject private var wordmeGame =  WordmeGame()
    var body: some Scene {
        WindowGroup {
            WordmeView()
                .environmentObject(wordmeGame)
        }
    }
}
