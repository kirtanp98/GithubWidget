//
//  Contribution.swift
//  GithubContributions
//
//  Created by Kirtan Patel on 12/19/20.
//

import Foundation

struct Contribution {
    let date: Date
    let level: Int //make to enum
    let count: Int
}

struct Contribute {
    let date: Date
    let level: Int //make to enum
    let count: Int
    
    static var levels = [String]()
    
    static func colorToLevel(_ string: String) -> Int {
        return levels.firstIndex(of: string) ?? 0
    }
}
