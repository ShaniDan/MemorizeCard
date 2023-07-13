//
//  ListFlashcardView.swift
//  MemorizeCard
//
//  Created by Shakhnoza Mirabzalova on 6/28/23.
//

import SwiftUI

struct ListFlashcardView: View {
    @State public var textField: String = ""
    @State var currentSet: UUID?
    @State var show = false
    @StateObject var mainViewModel: CardViewModel = CardViewModel()
    @State var bottomSheet = false
  
    
    var body: some View {
        NavigationStack {
            ZStack {
                    List {
                    ForEach(mainViewModel.allFlashcardSets, id: \.flashcardSetName) { cardSet in
                        NavigationLink(destination: FlashcardView(set: cardSet, mainViewModel: mainViewModel)) {
                            Text(cardSet.flashcardSetName)
                                .font(.headline)
                            }
                        }
                    .onDelete(perform: mainViewModel.deleteCardSet)
                    
                }
                    .listStyle(InsetGroupedListStyle())
                    .navigationTitle("My Flashcards")
                    .foregroundColor(Color("Dark Slate Gray"))
            // FloatingButton
                VStack {
                    Spacer()
                    HStack {
                        Spacer()
                        FloatingButton(show: $show, mainViewModel: mainViewModel)
                    }
                }
                .padding()
               }
            .onAppear {
                mainViewModel.loadCardSets()
            }
            }
        .navigationBarBackButtonHidden(true)
        }
    }

struct ListFlashcardView_Previews: PreviewProvider {
    static var previews: some View {
        ListFlashcardView()
    }
}



struct FloatingButton: View {
    @Binding var show: Bool
    @ObservedObject var mainViewModel: CardViewModel
    @State public var textField: String = ""
    @State var currentSet: UUID?
    @State var bottomSheet = false
    
    init(show: Binding<Bool>, mainViewModel: CardViewModel) {
        _show = show
        self.mainViewModel = mainViewModel
    }
    
    var body: some View {
        VStack {
            Button(action: {
                self.show.toggle()
                bottomSheet.toggle()
            }) {
                Image(systemName: "plus").resizable().frame(width: 30, height: 30).padding(15)
            }
            .background(Color("Cadet Green"))
            .foregroundColor(Color("Light Steel Blue"))
            .clipShape(Circle())
            .rotationEffect(.init(degrees: self.show ? 180 : 0))
            .animation(.easeInOut(duration: 0.4), value: show)
            .sheet(isPresented: $bottomSheet) {
                VStack {
                    Text("New set name")
                        .font(.headline)
                    TextField("Title", text: $textField)
                        .padding()
                        .background(Color(.systemGray6))
                        .cornerRadius(20)
                    Button {
                        currentSet = mainViewModel.addSet(name: textField)
                        textField = ""
                    } label: {
                        Text("Save")
                    }
                }
                .padding()
                .presentationDetents([.medium])
                .presentationDragIndicator(.visible)
                .background(.orange).ignoresSafeArea()
            }
        }
        .padding(30)
    }
}


