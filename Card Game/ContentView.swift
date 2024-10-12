//
//  ContentView.swift
//  Card Game
//
//  Created by Andrew Liu on 2024-09-18.
//

import SwiftUI

struct CardGameView: View {
    // implements the Observer Design Pattern, re-render when the observed object changes
    @ObservedObject var viewModel: MemoryGameViewModel
    
    let emojis = ["A", "B", "C", "D", "E"]
    @State var cardCount: Int = 4
    var body: some View {
        VStack{
            ScrollView{
                cards
            }
            Button("Shuffle"){
                viewModel.shuffle()
            }
        }
        .foregroundColor(.blue)
        .padding()
            
    }
    
    var cards: some View {
        // GridItem .adaptive controls the size of the cards
        LazyVGrid (columns: [GridItem(.adaptive(minimum: 100), spacing: 0)], spacing: 0) {
            ForEach(viewModel.cards.indices, id: \.self){ index in
                CardView(viewModel.cards[index])
                    .aspectRatio(2/3, contentMode: .fit)
                    .padding(4)
                
            }
        }
    }
    
}


struct CardView: View {
    let card: MemoryGame<String>.Card
    
    init(_ card: MemoryGame<String>.Card) {
        self.card = card
    }
    
    var body: some View {
        ZStack{
            let base = RoundedRectangle(cornerRadius: 12)
            Group{
                base.fill(.white)
                base.strokeBorder(lineWidth: 2)
                Text(card.content)
                    .font(.system(size:200))
                    .minimumScaleFactor(0.01)
                    .aspectRatio(1, contentMode: .fit)
            }
            .opacity(card.isFaceUp ? 1:0)
            base.fill()
                .opacity(card.isFaceUp ? 0:1)
        }
    }
    
}


struct CardGameView_Preview: PreviewProvider{
    static var previews: some View{
        CardGameView(viewModel: MemoryGameViewModel())
    }
}
