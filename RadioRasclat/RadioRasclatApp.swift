//
//  RadioRasclatApp.swift
//  RadioRasclat
//
//  Created by Domenik Töfflinger on 19.11.20.
//

import SwiftUI

@main
struct RadioRasclatApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
