//
//  AuthManager.swift
//  GithubContributions
//
//  Created by Kirtan Patel on 12/21/20.
//

import Foundation

class AuthManager: ObservableObject {
    @Published var loginedIn: Bool
    @Published var userName: String
    @Published var imageURL: String
    
    
    init() {
        let key = UserDefaults(suiteName: "group.contributions.data")!.string(forKey: "authkey") ?? ""
        if !key.isEmpty {
            loginedIn = true
            userName = ""
            imageURL = ""
            getCurrentUserInfo()
        } else {
            loginedIn = false
            userName = ""
            imageURL = ""
        }
    }
    
    func updateStatus(authKey: String) {
        loginedIn = true
        UserDefaults(suiteName: "group.contributions.data")!.setValue(authKey, forKey: "authkey")
        getCurrentUserInfo()
    }
    
    func logOut() {
        UserDefaults(suiteName: "group.contributions.data")!.setValue("", forKey: "authkey")
        loginedIn = false
        userName = ""
        imageURL = ""
    }
    
    func getCurrentUserInfo() {
        Network.shared.apollo.fetch(query: GetCurrentUserQuery()) { result in
            switch result {
            case .success(let graphQLResult):
                DispatchQueue.main.async {
                    self.userName = graphQLResult.data?.viewer.name ?? ""
                    self.imageURL = graphQLResult.data?.viewer.avatarUrl ?? ""
                    print(self.imageURL)
                }
            case .failure(let error):
                print("Failure! Error: \(error)")
                self.logOut()
            }
        }
    }
}
