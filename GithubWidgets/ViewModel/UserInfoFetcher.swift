//
//  UserInfoFetcher.swift
//  GithubWidgetsExtension
//
//  Created by Kirtan Patel on 1/2/21.
//

import Foundation
import Apollo

class UserInfoFetcher {
    var userName: String
    var realName: String
    var imageURL: String
    
    init() {
        userName = ""
        realName = ""
        imageURL = ""
    }

    func getCurrentUserInfo(completionHanlder:  @escaping ((_ userInfo: Bool) -> Void) ) {
        Network.shared.apollo.fetch(query: GetCurrentUserQuery()) { result in
            switch result {
            case .success(let graphQLResult):
                DispatchQueue.main.async {
                    self.userName = graphQLResult.data?.viewer.login ?? ""
                    self.realName =  graphQLResult.data?.viewer.name ?? ""
                    self.imageURL = graphQLResult.data?.viewer.avatarUrl ?? ""
                    completionHanlder(true)
                }
            case .failure(let error):
                print("Failure! Error: \(error)")
                print(error.localizedDescription)
                completionHanlder(false)

                if error.localizedDescription.contains("401") {
                    print("hmm")
                }
                
                if error.localizedDescription.contains("offline") {
                    print("hmm")
                }
            }
        }
    }
}
