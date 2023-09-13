//
//  BUS101App.swift
//  BUS101
//
//  Created by mitchell tucker on 9/5/23.
//

import SwiftUI

@main
struct BUS101App: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
