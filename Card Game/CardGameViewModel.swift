//
//  CardGameViewModel.swift
//  Card Game
//
//  Created by Andrew Liu on 2024-09-19.
//

import SwiftUI


// must know about UI, should not be private

class MemoryGameViewModel: ObservableObject{
    // static makes the emojis global but namespace inside of the class -> real name is MemoryGameViewModel.emojis
    private static let emojis = ["A", "B", "C", "D", "E"]
    
    // swift can never infer a return type
    private static func createMemoryGame() -> MemoryGame<String>{
        return MemoryGame(numberOfPairs: 10){ pairIndex in
            if emojis.indices.contains(pairIndex){
                return emojis[pairIndex]
            } else {
                return "😅"
            }
        }
    }
    
    // determine CardContent as a String
    @Published private var model = createMemoryGame()
    
    var cards: Array<MemoryGame<String>.Card>{
        return model.cards
    }
    
    func choose(_ card: MemoryGame<String>.Card){
        model.choose(card)
    }
    
    // MARK: - Intents
    
    func shuffle(){
        model.shuffle()
    }
}
