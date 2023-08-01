//
//  CardModel.swift
//  MemorizeCard
//
//  Created by Shakhnoza Mirabzalova on 6/28/23.
//

import Foundation

struct CardModel : Codable, Identifiable, Hashable {
    var id = UUID()
    var question : String
    var answer : String
}

// A struct to store one FlashCard set's data
struct FlashcardSet : Codable, Identifiable, Hashable {
    var id = UUID()
    var flashcardSetName : String
    var flashCards : [CardModel] = []
}
