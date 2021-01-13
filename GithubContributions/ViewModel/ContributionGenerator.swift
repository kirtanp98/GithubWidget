//
//  ContributionGenerator.swift
//  GithubContributions
//
//  Created by Kirtan Patel on 1/12/21.
//

import Foundation

class ContributionGenerator: ObservableObject {
    @Published var contributions: [Contribute] = []
    
    func generate() {
        if contributions.count > 0 {
            return
        }
        let currentDate = Date()
        for x in (0..<200) {
            let time = currentDate.addingTimeInterval(TimeInterval(x))
            let level = Int.random(in: 0..<5)
            let count = Int.random(in: 0..<10)
            let temp = Contribute(date: time, level: level, count: count)
            
            contributions.append(temp)
        }
    }
}
