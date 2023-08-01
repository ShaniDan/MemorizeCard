//
//  FlashcardView.swift
//  MemorizeCard
//
//  Created by Shakhnoza Mirabzalova on 6/28/23.
//

import SwiftUI

struct FlashcardView: View {
    @State var flipped = false
    @State var set: FlashcardSet
    @State private var isShowingUpdateView = false
    @ObservedObject var mainViewModel: CardViewModel
    @State private var offset = CGSize.zero
    @State private var targetOffset = CGSize.zero
    
    init(set: FlashcardSet, mainViewModel: CardViewModel) {
        _set = State(initialValue: set)
        self.mainViewModel = mainViewModel
    }
    
    // MARK: - Computed properties
    
    var body: some View {
//        NavigationStack {
            VStack {
                Text(set.flashcardSetName)
                    .foregroundColor(Color("Dark Slate Gray"))
                    .bold()
                    .font(.title)
                    .padding()
                    VStack { ScrollView(.horizontal) {
                        LazyHGrid(rows: [GridItem(.flexible())]) {
                            ForEach(set.flashCards, id: \.id) { flashcard in
                                ZStack {
                                    Rectangle()
                                        .fill(flipped ? Color("Color 2") : Color("Color 1"))
                                        .frame(width: 350, height: 300)
                                        .cornerRadius(15)
                                        .rotation3DEffect(.degrees(flipped ? 180 : 0), axis: (x: 0.0, y: 1.0, z: 0.0))
                                        .onTapGesture {
                                            withAnimation { self.flipped.toggle()
                                            }
                                        }
                                    Text(flipped ? flashcard.answer : flashcard.question)
                                        .foregroundColor(.white)
                                        .bold()
                                        .rotation3DEffect(.degrees(flipped ? 180 : 0), axis: (x: 0.0, y: 0.0, z: 0.0)
                                        )
                                        .frame(width: 330, height: 280)
                                }
                                .padding()
                            }
                        }
                    }
                    }
                    .frame(width: 370, height: 400)
                 Spacer()
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
                        NavigationLink(destination: GridFlashcards(set: set, mainViewModel: mainViewModel), label: {
                            Text("Grid")
                        })
            }
            .onAppear {
                mainViewModel.loadCardSets()
            }
            .toolbar {
                ToolbarItem(placement: ToolbarItemPlacement
                    .navigationBarTrailing) {
                        NavigationLink(destination: EditFlashcardView(set: $set, mainViewModel: mainViewModel)) {
                            Text("Edit")
                        }
                    }
            }
    }

    }

struct FlashcardView_Previews: PreviewProvider {
    static var previews: some View {
        FlashcardView(set: FlashcardSet(flashcardSetName: "Test"), mainViewModel: CardViewModel())
    }
}

