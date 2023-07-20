//
//  FlashcardView.swift
//  MemorizeCard
//
//  Created by Shakhnoza Mirabzalova on 6/28/23.
//

import SwiftUI

struct FlashcardView: View {
    @State var flipped = false
    @State var currentIndex: Int = 0
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
    
    var currentCard: CardModel? {
        if currentIndex < set.flashCards.count {
            return set.flashCards[currentIndex]
        } else {
            return nil
        }
    }
    
    var body: some View {
        NavigationStack {
            VStack {
                Text(set.flashcardSetName)
                    .foregroundColor(Color("Dark Slate Gray"))
                    .bold()
                    .font(.title)
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
                    
                    VStack {
                        if let card = currentCard {
                            Text(flipped ? card.answer : card.question)
                                .foregroundColor(.white)
                                .bold()
                        } else {
                            Text("No cards")
                        }
                    }
                    .padding()
                    .rotation3DEffect(.degrees(flipped ? 180 : 0), axis: (x: 0.0, y: 0.0, z: 0.0)
                    )
                    .frame(width: 330, height: 280)
                }
                .offset(x: offset.width)
                .gesture(
                    DragGesture()
                        .onChanged { value in
                            offset = value.translation
                        }.onEnded { value in
                            withAnimation {
                                swipeCard(width: value.translation.width)
                                offset = .zero
                            }
                        }
                )
                HStack() {
                    VStack() {
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
                .padding(50)
            }
            .onAppear {
                mainViewModel.loadCardSets()
            }
            .toolbar {
                ToolbarItem(placement: ToolbarItemPlacement
                    .navigationBarTrailing) {
                        NavigationLink(destination: EditFlashcardView(set: set, mainViewModel: mainViewModel)) {
                            Text("Edit")
                        }
                    }
            }
        }
    }
        private func swipeCard(width: CGFloat) {
            let dragThreshold: CGFloat = 150
            
            if width < -dragThreshold {
                if currentIndex < set.flashCards.count - 1 {
                    currentIndex += 1
                    targetOffset = CGSize(width: -300, height: 0)
                }
            } else if width > dragThreshold {
                if currentIndex > 0 {
                    currentIndex -= 1
                    targetOffset = CGSize(width: 300, height: 0)
                }
            }
        }
    }

struct FlashcardView_Previews: PreviewProvider {
    static var previews: some View {
        FlashcardView(set: FlashcardSet(flashcardSetName: "Test"), mainViewModel: CardViewModel())
    }
}

