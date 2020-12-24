//
//  CColor+CoreDataProperties.swift
//  GithubContributions
//
//  Created by Kirtan Patel on 12/23/20.
//
//

import Foundation
import CoreData
import SwiftUI

extension CColor {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CColor> {
        return NSFetchRequest<CColor>(entityName: "CColor")
    }

    @NSManaged public var light: Data?
    @NSManaged public var dark: Data?
    @NSManaged public var id: UUID?
    @NSManaged public var level: Int16
    @NSManaged public var origin: Palette?
    
    public var wrappedLevel: Int {
        return Int(level)
    }
    
    public var wrappedID: UUID {
        return id ?? UUID()
    }
    
    public var wrappedLightColor: Color {
        if let lightColor = light {
            return getColour(data: lightColor)
        }else{
            return .blue
        }
    }
    
    public var wrappedDarkColor: Color {
        if let darkColor = dark {
            return getColour(data: darkColor)
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

extension CColor : Identifiable {

}
