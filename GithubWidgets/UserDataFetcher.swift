//
//  UserDataFetcher.swift
//  GithubWidgetsExtension
//
//  Created by Kirtan Patel on 12/20/20.
//

import Foundation

class UserDataFetcher {
    var contributions: [Contribute]
    var totalContribution: Int
    var user: String
    
    private var dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        return dateFormatter
    }()
    
    init() {
        self.user = ""
        contributions = []
        totalContribution = 0
    }
    
    func fetchData(user: String, completionHanlder: @escaping (_ con: [Contribute])->Void){
        self.user = user
        
        Network.shared.apollo.fetch(query: GetUserContributionsQuery(login: user)) { result in
            switch result {
            case .success(let graphQLResult):
                //DispatchQueue.main.async {
                    self.totalContribution = graphQLResult.data?.user?.contributionsCollection.contributionCalendar.totalContributions ?? 0

                    Contribute.levels = graphQLResult.data?.user?.contributionsCollection.contributionCalendar.colors ?? []
                    Contribute.levels.insert("#ebedf0", at: 0)
                    
                    self.contributions = (graphQLResult.data?.user?.contributionsCollection.contributionCalendar.weeks
                        .flatMap{ $0.contributionDays }
                                            .compactMap{ Contribute(date: self.dateFormatter.date(from: $0.date)!, level: Contribute.colorToLevel($0.color), count: $0.contributionCount) })!
                    
                    completionHanlder(self.contributions)
                //}
            case .failure(let error):
                print("Failure! Error: \(error)")
            }
        }
    }
}
