//
//  CoreDataFetcher.swift
//  GithubContributions
//
//  Created by Kirtan Patel on 12/31/20.
//

import Foundation
import CoreData
import SwiftUI

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
    
    func getColorByID(uuid: String) -> Palette? {
        let request = NSFetchRequest<Palette>(entityName: "Palette")
        request.fetchLimit = 1
        
        guard let id = UUID(uuidString: uuid) else { return nil }
        
        request.predicate = NSPredicate(format: "id == %@", id as NSUUID)
        
        do {
            let color = try container.viewContext.fetch(request)
            if color.isEmpty {
                return nil
            }
            return color[0]
        } catch {
            print("Error Fetching ID: \(uuid)")
        }
        
        return nil
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
    
    func getBackgroundByID(uuid: String) -> Background? {
        let request = NSFetchRequest<Background>(entityName: "Background")
        request.fetchLimit = 1
        
        guard let id = UUID(uuidString: uuid) else { return nil }
        
        request.predicate = NSPredicate(format: "id == %@", id as NSUUID)
        
        do {
            let background = try container.viewContext.fetch(request)
            return background[0]
        } catch {
            print("Error Fetching ID: \(uuid)")
        }
        
        return nil

    }
}
