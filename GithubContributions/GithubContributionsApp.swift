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
    @StateObject var authState = AuthManager()

    var body: some Scene {
        WindowGroup {
            BaseView()
            //ContentView()
                .environmentObject(authState)
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
