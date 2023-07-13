//
//  EditFlashcardView.swift
//  MemorizeCard
//
//  Created by Shakhnoza Mirabzalova on 6/28/23.
//

import SwiftUI

struct EditFlashcardView: View {
    @State var set: FlashcardSet
    @ObservedObject var mainViewModel: CardViewModel
    
    init(set: FlashcardSet, mainViewModel: CardViewModel) {
        _set = State(initialValue: set)
        self.mainViewModel = mainViewModel
    }
    
    var body: some View {
        ZStack {
            VStack {
                Text("Name")
                TextField("Enter Card Set Name", text: $set.flashcardSetName)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                List {
                    ForEach(0..<set.flashCards.count, id: \.self) { index in
                        VStack {
                            TextField("Question", text: $set.flashCards[index].question)
                            TextField("Answer", text: $set.flashCards[index].answer)
                        }
                    }
                    .onDelete { indices in
                        if let updatedSet = mainViewModel.deleteCards(at: indices, in: set) {
                            set = updatedSet
                        }
                    }
                }
                .listStyle(.grouped)
            }
        }
        .toolbar {
            ToolbarItem(placement: ToolbarItemPlacement
                .navigationBarTrailing) {
                    Button(action: {
                        if mainViewModel.updateCardSet(cardSetID: set.id, newName: set.flashcardSetName) != nil {
                            for card in set.flashCards {
                                _ = mainViewModel.updateCards(cardID: card.id,
                                                              newQuestionName: card.question,
                                                              newAnswerName: card.answer)
                            }
                        }
                    }, label: {
                        Text("Save")
                    })
                }
        }
    }
}

struct EditFlashcardView_Previews: PreviewProvider {
    static var previews: some View {
        EditFlashcardView(set: FlashcardSet(flashcardSetName: "Test"), mainViewModel: CardViewModel())
    }
}

