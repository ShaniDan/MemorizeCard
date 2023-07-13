//
//  AddCardView.swift
//  MemorizeCard
//
//  Created by Shakhnoza Mirabzalova on 6/28/23.
//

import SwiftUI

struct AddCardView: View {
    @State public var text1: String = ""
    @State public var text2: String = ""
    @State public var textField: String = ""
    @State var currentSet: UUID?
    @State var set: FlashcardSet
    @State var selection = FlashcardSet(flashcardSetName: "")
    @ObservedObject var mainViewModel: CardViewModel
    
    init(set: FlashcardSet, mainViewModel: CardViewModel) {
        _set = State(initialValue: set)
        self.mainViewModel = mainViewModel
    }
    
    var body: some View {
            VStack {
                HStack {
                    Text(set.flashcardSetName)
//                    Text("Choose a set")
//                        .padding(.leading)
//                        .font(.headline)
//                    Spacer()
//                    Picker("Choose Set", selection: $selection) {
//                        ForEach(mainViewModel.allFlashcardSets, id: \.flashcardSetName) { set in
//                            Text(set.flashcardSetName).tag(set)
//                        }
//                    }
//                    .pickerStyle(.automatic)
//                    .padding(.trailing, 8)
//                    .frame(alignment: .trailing)
//                    .background(Rectangle()).cornerRadius(8).foregroundColor(Color(.systemGray5))
//                    .onChange(of: selection) { newValue in
//                        currentSet = newValue.id
//                    }
                }
                .padding(.trailing, 8)
                .toolbar {
                    ToolbarItem(placement: ToolbarItemPlacement
                        .navigationBarTrailing) {
                            Button {
                                // MARK: Need to add the card to the saved title name
                                mainViewModel.add(card: CardModel(question: text1, answer: text2), to: set.id)
                                text1 = ""
                                text2 = ""
                            } label: {
                                Image(systemName: "plus")
                            }
                        }
                }
                
                ScrollView {
                    VStack {
                        // First view of the TextEditor
                        Text("Question")
                            .foregroundColor(.gray);
                        TextEditor(text: $text1)
                            .frame(height: 250)
                            .overlay(
                                RoundedRectangle(cornerRadius: 16)
                                    .stroke(.gray.opacity(0.2), lineWidth: 2)
                            )
                        // Second view of the TextEditor
                        Text("Answer")
                            .foregroundColor(.gray);
                        TextEditor(text: $text2)
                            .frame(height: 250)
                            .overlay(
                                RoundedRectangle(cornerRadius: 16)
                                    .stroke(.gray.opacity(0.2), lineWidth: 2)
                            )
                    }
                    .padding()
                }
            }
    }
}

struct AddCardView_Previews: PreviewProvider {
    static var previews: some View {
        AddCardView(set: FlashcardSet(flashcardSetName: "Test"), mainViewModel: CardViewModel())
    }
}
