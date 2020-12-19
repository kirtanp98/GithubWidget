//
//  GithubContributionsApp.swift
//  GithubContributions
//
//  Created by Kirtan Patel on 12/19/20.
//

import SwiftUI

@main
struct GithubContributionsApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
