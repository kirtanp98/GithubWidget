//
//  GithubContributionsApp.swift
//  GithubContributions
//
//  Created by Kirtan Patel on 12/19/20.
//

import SwiftUI
import WidgetKit

@main
struct GithubContributionsApp: App {
    @Environment(\.scenePhase) var scenePhase
    
    let persistenceController = PersistenceController.shared
    @StateObject var authState = AuthManager()

    var body: some Scene {
        WindowGroup {
            BaseView()
                .environmentObject(authState)
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
                .onChange(of: scenePhase) { newScenePhase in
                      switch newScenePhase {
                      case .active:
                        print("App is active")
                      case .inactive:
                        print("App is inactive")
                      case .background:
                        print("App is in background")
                        WidgetCenter.shared.reloadAllTimelines()
                      @unknown default:
                        print("Oh - interesting: I received an unexpected new value.")
                      }
                }
        }
    }
}
