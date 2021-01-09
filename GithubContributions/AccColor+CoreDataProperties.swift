//
//  AccColor+CoreDataProperties.swift
//  GithubContributions
//
//  Created by Kirtan Patel on 1/9/21.
//
//

import Foundation
import CoreData
import SwiftUI


extension AccColor {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<AccColor> {
        return NSFetchRequest<AccColor>(entityName: "AccColor")
    }

    @NSManaged public var name: String?
    @NSManaged public var id: UUID?
    @NSManaged public var date: Date?
    @NSManaged public var light: Data?
    @NSManaged public var dark: Data?
    
    public var wrappedName: String {
        return name ?? ""
    }
    
    public var wrappedId: UUID {
        return id ?? UUID()
    }
    
    public var wrappedDate: Date {
        return date ?? Date()
    }
    
    public var wrappedLight: Color {
        if let light = light {
            return getColour(data: light)
        }else{
            return .blue
        }
    }
    
    public var wrappedDark: Color {
        if let dark = dark {
            return getColour(data: dark)
        }else{
            return .blue
        }
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

extension AccColor : Identifiable {

}
