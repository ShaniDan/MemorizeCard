//
//  GridFlashcards.swift
//  MemorizeCard
//
//  Created by Shakhnoza Mirabzalova on 7/21/23.
//

import SwiftUI

struct GridFlashcards: View {
    @State var set: FlashcardSet
    @ObservedObject var mainViewModel: CardViewModel
    @State var flipped = false
    var body: some View {
        ScrollView(.horizontal) {
            LazyHGrid(rows: [GridItem(.flexible())]) {
                ForEach(set.flashCards, id: \.id) { flashcard in
                    ZStack {
//                        HStack {
                            Rectangle()
                                .fill(flipped ? Color("Color 2") : Color("Color 1"))
                                .frame(width: 350, height: 300)
                                .cornerRadius(15)
                                .rotation3DEffect(.degrees(flipped ? 180 : 0), axis: (x: 0.0, y: 1.0, z: 0.0))
                                .onTapGesture {
                                    withAnimation { self.flipped.toggle()
                                    }
                                }
//                        }
                        Text(flipped ? flashcard.question : flashcard.answer )
                        //                    Text(flashcard.question)
                        //                    Text(flashcard.answer)
                    }
                    .padding()
                }
            }
        }
        NavigationLink(destination: AddCardView(set: $set, mainViewModel: mainViewModel), label: {
            RoundedRectangle(cornerRadius: 10)
                .frame(width: 330, height: 55)
                .foregroundColor(Color("Color 2"))
                .overlay(
                    Text("Add Card")
                        .foregroundColor(.white)
                        .bold()
                )
        })
    }

}

struct GridFlashcards_Previews: PreviewProvider {
    static var previews: some View {
        GridFlashcards(set: FlashcardSet(flashcardSetName: "Test",flashCards: []), mainViewModel: CardViewModel())
    }
}
