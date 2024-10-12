//
//  CardGameModel.swift
//  Card Game
//
//  Created by Andrew Liu on 2024-09-19.
//

import Foundation

struct MemoryGame<CardContent>{
    // use generic CardContent type to be defined by the ViewModel
    private(set) var cards: Array<Card>
    
    init(numberOfPairs: Int, cardContentFactory: (Int) -> CardContent){
        cards = [Card]()
        // add numberOfPairs x 2 cards
        for pairIndex in 0..<max(2,numberOfPairs){
            let content = cardContentFactory(pairIndex)
            cards.append(Card(content: content))
            cards.append(Card(content: content))
        }
    }
    
    func choose(_ card:Card){
        
    }
    
    // you must mark mutating when mutating with structs
    mutating func shuffle(){
        cards.shuffle()
        print(cards)
    }
    
    struct Card{
        var isFaceUp: Bool = true
        var isMatched: Bool = false
        // card content shouldn't be changing so use a let
        let content: CardContent
        
    }
}
