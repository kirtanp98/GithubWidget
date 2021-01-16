//
//  OtherUserInfoFetcher.swift
//  GithubWidgetsExtension
//
//  Created by Kirtan Patel on 1/16/21.
//

import Foundation
import Apollo

class OtherUserInfoFetcher {
    var userName: String
    var imageURL: String
    
    init() {
        userName = ""
        imageURL = ""
    }

    func getOtherUserInfo(user: String, completionHanlder:  @escaping ((_ userInfo: Bool) -> Void) ) {
        Network.shared.apollo.fetch(query: GetUserInfoQuery(login: user)) { result in
            switch result {
            case .success(let graphQLResult):
                DispatchQueue.main.async {
                    self.userName = graphQLResult.data?.user?.name ?? ""
                    self.imageURL = graphQLResult.data?.user?.avatarUrl ?? ""
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
