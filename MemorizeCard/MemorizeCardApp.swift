//
//  MemorizeCardApp.swift
//  MemorizeCard
//
//  Created by Shakhnoza Mirabzalova on 6/28/23.
//

import SwiftUI

@main
struct MemorizeCardApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
