//
//  Background+CoreDataProperties.swift
//  GithubContributions
//
//  Created by Kirtan Patel on 12/26/20.
//
//

import Foundation
import CoreData
import SwiftUI

extension Background {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Background> {
        return NSFetchRequest<Background>(entityName: "Background")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var name: String?
    @NSManaged public var date: Date?
    @NSManaged public var isImage: Bool
    @NSManaged public var lightColor: Data?
    @NSManaged public var darkColor: Data?
    @NSManaged public var darkBackground: Data?
    @NSManaged public var lightBackground: Data?

    public var wrappedID: UUID {
        return id ?? UUID()
    }
    
    public var wrappedName: String {
        return name ?? ""
    }
    
    public var wrappedDate: Date {
        return date ?? Date()
    }
    
    public var wrappedLightColor: Color {
        if let lightColor = lightColor {
            return getColour(data: lightColor)
        }else{
            return .blue
        }
    }
    
    public var wrappedDarkColor: Color {
        if let darkColor = darkColor {
            return getColour(data: darkColor)
        }else{
            return .blue
        }
    }
    
    public var wrappedLightBackground: UIImage? {
        if let lightBackground = lightBackground {
            return UIImage(data: lightBackground)
        }
        return nil
    }
    
    public var wrappedDarkBackground: UIImage? {
        if let darkBackground = darkBackground {
            return UIImage(data: darkBackground)
        }
        return nil
    }
    
    func getColour(data: Data) -> Color {
        do {
            return try Color(NSKeyedUnarchiver.unarchivedObject(ofClass: UIColor.self, from: data)!)
        } catch {
            print(error)
        }

        return Color.blue
    }
}

extension Background : Identifiable {

}
