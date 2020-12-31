//
//  CoreDataFetcher.swift
//  GithubContributions
//
//  Created by Kirtan Patel on 12/31/20.
//

import Foundation
import CoreData

class DataFetcher {
    var container: NSPersistentContainer

    init() {
        let tempContainer = NSPersistentContainer(name: "GithubContributions")
        let storeURL = URL.storeURL(for: "group.contributions.data", databaseName: "contributions")
        let description = NSPersistentStoreDescription(url: storeURL)
        tempContainer.persistentStoreDescriptions = [description]
        
        
        tempContainer.loadPersistentStores {(storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        }
        self.container = tempContainer
    }
    
    func getColors() -> [Palette] {
        let request = NSFetchRequest<Palette>(entityName: "Palette")
        
        do {
            let colors = try container.viewContext.fetch(request)
            print("Got \(colors.count) commits")
            return colors
        } catch {
            print("Fetch failed")
        }
        
        return []
    }
    
    func getBackgrounds() -> [Background] {
        let request = NSFetchRequest<Background>(entityName: "Background")
        
        do {
            let backgrounds = try container.viewContext.fetch(request)
            print("Got \(backgrounds.count) commits")
            return backgrounds
        } catch {
            print("Fetch failed")
        }
        
        return []
    }
}
