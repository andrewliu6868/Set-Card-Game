//
//  Card_GameApp.swift
//  Card Game
//
//  Created by Andrew Liu on 2024-09-18.
//

import SwiftUI

@main
struct Card_GameApp: App {
    @StateObject var game = MemoryGameViewModel()
    var body: some Scene {
        WindowGroup {
            CardGameView(viewModel: game)
        }
    }
}
