//
//  MomoApp.swift
//  Momo
//
//  Created by Tsenguun on 2/8/22.
//

import SwiftUI

@main
struct MomoApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            EntryView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
