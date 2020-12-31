//
//  Palette+CoreDataProperties.swift
//  GithubContributions
//
//  Created by Kirtan Patel on 12/23/20.
//
//

import Foundation
import CoreData
import SwiftUI

extension Palette {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Palette> {
        return NSFetchRequest<Palette>(entityName: "Palette")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var date: Date?
    @NSManaged public var colors: NSSet?
    @NSManaged public var name: String?
    
    public var colorArray: [CColor] {
        let set = colors as? Set<CColor> ?? []
        
        return set.sorted {
            $0.wrappedLevel > $1.wrappedLevel
        }
    }
    
    public var lightColorArray: [Color] {
        return colorArray.map{ $0.wrappedLightColor }
    }
    
    public var darkColorArray: [Color] {
        return colorArray.map{ $0.wrappedDarkColor }
    }
    
    public var wrappedId: UUID {
        return id ?? UUID()
    }
    
    public var wrappedDate: Date {
        return date ?? Date()
    }
    
    public var wrappedName: String {
        return name ?? ""
    }

}

// MARK: Generated accessors for colors
extension Palette {

    @objc(addColorsObject:)
    @NSManaged public func addToColors(_ value: CColor)

    @objc(removeColorsObject:)
    @NSManaged public func removeFromColors(_ value: CColor)

    @objc(addColors:)
    @NSManaged public func addToColors(_ values: NSSet)

    @objc(removeColors:)
    @NSManaged public func removeFromColors(_ values: NSSet)

}

extension Palette : Identifiable {

}
