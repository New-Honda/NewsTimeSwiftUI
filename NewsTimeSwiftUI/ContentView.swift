//
//  ContentView.swift
//  NewsTimeSwiftUI
//
//  Created by Developer on 29.09.2024.
//

import SwiftUI
import CoreData

struct ContentView: View {

    @Environment(\.managedObjectContext) private var viewContext

    var body: some View {
        TabView {
            NewsView(viewModel: NewsAPIViewModel(viewContext: viewContext, apiType: .mostViewed))
                .tabItem {
                    Label("Most Viewed", systemImage: "list.number")
                }
            NewsView(viewModel: NewsAPIViewModel(viewContext: viewContext, apiType: .mostShared))
                .tabItem {
                    Label("Most Shared", systemImage: "square.and.arrow.up")
                }
            NewsView(viewModel: NewsAPIViewModel(viewContext: viewContext, apiType: .mostEmailed))
                .tabItem {
                    Label("Most Emailed", systemImage: "envelope.fill")
                }
            NewsView(viewModel: NewsViewModel(viewContext: viewContext))
                .tabItem {
                    Label("Favorites", systemImage: "star.fill")
                }
        }
    }
}

private let itemFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.timeStyle = .medium
    return formatter
}()

#Preview {
    ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
}
