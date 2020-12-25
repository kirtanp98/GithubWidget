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
    @StateObject var modalController = ModalController()

    var body: some Scene {
        WindowGroup {
            BaseView()
            //ContentView()
                .environmentObject(authState)
                .environmentObject(modalController)
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
