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
    
    var indexOfOnlyUpCard: Int? {
        // getters are for retrieving content within a class
        get{cards.indices.filter {index in cards[index].isFaceUp}.only}
        // setters are for altering content within a class, newValue is a builtin parameter
        set{cards.indices.forEach {cards[$0].isFaceUp = (newValue == $0)}}
    }
    
    mutating func choose(_ card:Card){
        if let chosenIndex = cards.firstIndex(where: {$0.id == card.id}){
            if !cards[chosenIndex].isFaceUp && !cards[chosenIndex].isMatched{
                if let currIndex = indexOfOnlyUpCard{
                    if cards[chosenIndex].content == cards[currIndex].content{
                        cards[chosenIndex].isMatched = true
                        cards[currIndex].isMatched = true
                    }
                }else{
                    indexOfOnlyUpCard = chosenIndex
                }
                cards[chosenIndex].isFaceUp = true
            }
        }
    }
    
    
    // you must mark mutating when mutating with structs
    mutating func shuffle(){
        cards.shuffle()
        print(cards)
    }
    
    struct Card : Equatable, Identifiable, CustomDebugStringConvertible {
        var isFaceUp: Bool = false
        var isMatched: Bool = false
        // card content shouldn't be changing so use a let
        let content: CardContent
        
        var id: String
        
        var debugDescription: String {
            "\(id): \(content) \(isFaceUp ? "up" : "down")\(isMatched ? "matched" : "")"
        }
    }
}

// extending array
extension Array {
    var only: Element? {
        count == 1 ? first : nil // don't need to explicitly state array.first because it's assumed you're applying these to arrays
    }
}
