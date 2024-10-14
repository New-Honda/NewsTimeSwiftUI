//
//  NewsTimeSwiftUIApp.swift
//  NewsTimeSwiftUI
//
//  Created by Developer on 29.09.2024.
//

import SwiftUI

@main
struct NewsTimeSwiftUIApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
