//
//  CardGameModel.swift
//  Card Game
//
//  Created by Andrew Liu on 2024-09-19.
//

import Foundation

struct MemoryGame<CardContent> where CardContent: Equatable{
    // use generic CardContent type to be defined by the ViewModel
    private(set) var cards: Array<Card>
    
    init(numberOfPairs: Int, cardContentFactory: (Int) -> CardContent){
        cards = [Card]()
        // add numberOfPairs x 2 cards
        for pairIndex in 0..<max(2,numberOfPairs){
            let content = cardContentFactory(pairIndex)
            cards.append(Card(content: content, id: "\(pairIndex+1)a"))
            cards.append(Card(content: content, id: "\(pairIndex+1)b"))
        }
    }
    
    mutating func choose(_ card:Card){
        let chosenIndex = index(of: card)
        cards[chosenIndex].isFaceUp.toggle()
    }
    
    func index (of card:Card) -> Int{
        for index in cards.indices {
            if cards[index].id == card.id{
                return index
            }
        }
        return 0 // FIXME: bogus!
    }
    
    // you must mark mutating when mutating with structs
    mutating func shuffle(){
        cards.shuffle()
        print(cards)
    }
    
    struct Card : Equatable, Identifiable, CustomDebugStringConvertible {
        var isFaceUp: Bool = true
        var isMatched: Bool = false
        // card content shouldn't be changing so use a let
        let content: CardContent
        
        var id: String
        
        var debugDescription: String {
            "\(id): \(content) \(isFaceUp ? "up" : "down")\(isMatched ? "matched" : "")"
        }
    }
}
