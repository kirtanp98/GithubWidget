//
//  ColorExtension.swift
//  GithubContributions
//
//  Created by Kirtan Patel on 12/19/20.
//

import Foundation
import SwiftUI

extension Color {
    static var githubGreen: [Color] =
        [Color(UIColor.systemGray5),
         Color(red: 1.0/255, green: 49.0/255, blue: 31/255),
         Color(red: 3.0/255, green: 69.0/255, blue: 37/255),
         Color(red: 15.0/255, green: 109.0/255, blue: 49/255),
         Color(red: 0.0/255, green: 198.0/255, blue: 71/255),
        ]
    
    static var testGreen: [Color] =
        [Color(UIColor.systemGray5),
         Color(red: 0, green: 100/255, blue: 0),
         Color(red: 0, green: 150/255, blue: 0),
         Color(red: 0, green: 200/255, blue: 0),
         Color(red: 0, green: 1, blue: 0),
        ]
    
    func toData() -> Data? {
        let uiColor = UIColor(self)
        
        let data = try? NSKeyedArchiver.archivedData(withRootObject: uiColor, requiringSecureCoding: false)
        return data
    }
}
