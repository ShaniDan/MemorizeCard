//
//  NewSetView.swift
//  MemorizeCard
//
//  Created by Shakhnoza Mirabzalova on 6/28/23.
//

//import SwiftUI
//
//struct NewSetView: View {
//    @State public var textField: String = ""
//    @State var currentSet: UUID?
//    @ObservedObject var mainViewModel: CardViewModel
//    
//    init(mainViewModel: CardViewModel) {
//        self.mainViewModel = mainViewModel
//    }
//    
//    var body: some View {
//        NavigationStack {
//            VStack {
//                Text("New set name")
//                    .font(.headline)
//                TextField("Title", text: $textField)
//                    .padding()
//                    .background(Color(.systemGray6))
//                    .cornerRadius(20)
//                
//            }
//            .padding()
//            
//            Button {
//                currentSet = mainViewModel.addSet(name: textField)
//                textField = ""
//            } label: {
//                Text("Save")
//            }
//        }
//    }
//}
//
//struct NewSetView_Previews: PreviewProvider {
//    static var previews: some View {
//        NewSetView(mainViewModel: CardViewModel())
//    }
//}
