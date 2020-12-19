//
//  GitHub.swift
//  GithubContributions
//
//  Created by Kirtan Patel on 12/19/20.
//

import Foundation
import SwiftSoup

struct GitHub {
    //https://github.com/users/kirtanp98/contributions
    
    static func loadDataToApp() throws -> [Contribution] {
        do {
            let endpoint = try getEndPointForUser("kirtanp98")
            let content = try getContentOfEndpoint(endpoint)
            let document = try SwiftSoup.parse(content)
            let colorLevels = try colors(from: document)
//            try document.select("rect").forEach { element in
//                let temp = try elementToContribution(element, colorLevels)
//                print(temp)
//            }
            let contributions = try document.select("rect").compactMap{ try elementToContribution($0, colorLevels) }
            return contributions
        } catch {
            print(error)
            throw error
        }
    }
    
    
    static func getContentOfEndpoint(_ url: URL) throws -> String {
//        DispatchQueue.global(qos: .userInitiated).async {}
        do {
            let content = try String(contentsOf: url)
            return content
        } catch {
            print(error)
            throw error
        }
    }
    
    static func getEndPointForUser(_ user: String) throws -> URL {
        guard let url = URL(string: "https://github.com/users/\(user)/contributions") else { throw URLError(.badURL) }
        return url
    }
    
    static func elementToContribution(_ element: Element, _ colorLevels: [String]) throws -> Contribution? {
        do {
            let dateData = try element.attr("data-date")
            let levelStyle = try element.attr("fill")
            let contributions = try element.attr("data-count")
            
            guard let date = dateFormatter.date(from: dateData) else { return nil }
            guard let count = Int(contributions) else { return nil }
            guard let level = colorLevels.firstIndex(where: { $0.contains(levelStyle) } ) else { return nil }
            return Contribution(date: date, level: level, count: count)
        } catch {
            print(error)
            return nil
        }
    }
    
    private static var dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        return dateFormatter
    }()
    
    //change code as yeeted
    private static func colors(from document: Document) throws -> [String] {
        try document.getElementsByClass("legend").first()?.children().map { try $0.attr("style") } ?? []
    }
}
