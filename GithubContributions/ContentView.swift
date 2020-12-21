//
//  ContentView.swift
//  GithubContributions
//
//  Created by Kirtan Patel on 12/19/20.
//x

import SwiftUI
import CoreData
import BetterSafariView

struct ContentView: View {
    
    @State var showAuthLogin = false
    
    var body: some View {
        NavigationView {
            List {
                Section {
                    Button(action: {
                        showAuthLogin.toggle()
                    }){
                        Label("Authenticate with GitHub", systemImage: "person.fill")
                    }
                }
                
                Section(header: Text("Stylize")) {
                    Label {
                        Text("Color Palette")
                     } icon: {
                        Image(systemName: "sparkles")
                            .renderingMode(.original)
                    }
                    
                    Label {
                        Text("Background")
                     } icon: {
                        Image(systemName: "sparkles")
                            .renderingMode(.original)
                    }
                }
                
                Section(header: Text("Tip")) {
                    Label {
                        Text("Money")
                     } icon: {
                        Image(systemName: "gift.fill")
                            .renderingMode(.original)
                    }
                    Label {
                        Text("Money")
                     } icon: {
                        Image(systemName: "gift.fill")
                            .renderingMode(.original)
                    }
                    Label {
                        Text("Money")
                     } icon: {
                        Image(systemName: "gift.fill")
                            .renderingMode(.original)
                    }
                }
                
                Section(header: Text("Contact")) {
                    Label {
                        Text("Twitter")
                     } icon: {
                        Text("🐦")
                    }
                }
                
            }
            .listStyle(InsetGroupedListStyle())
            .navigationTitle("Contributions")
            .webAuthenticationSession(isPresented: $showAuthLogin) {
                WebAuthenticationSession(
                    url: URL(string: "https://github.com/login/oauth/authorize?client_id=4254465c6344b733f4a6&allow_signup=true")!,
                    callbackURLScheme: "widgets://"
                ) { callbackURL, error in
//                    authManager.setCurrentAuthKey(callbackURL!.absoluteString)
//                    userManager.loadData()
                    print(callbackURL)
                    makePostRequet(callbackURL!.absoluteString)
                }
                .prefersEphemeralWebBrowserSession(false)
            }
        }
    }
    
    func makePostRequet(_ string: String) {
        let cleanKey = string.replacingOccurrences(of: "widgets://?code=", with: "")
        let url = URL(string: "https://github.com/login/oauth/access_token")
        
        var request = URLRequest(url: url!)
        request.httpMethod = "POST"
        let postString = "client_id=4254465c6344b733f4a6&client_secret=21f011b334577c626b8141a741a11a8bd495ca82&code=\(cleanKey)";
        request.httpBody = postString.data(using: String.Encoding.utf8);
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
                if let error = error {
                    print("Error took place \(error)")
                    return
                }
                if let data = data, let dataString = String(data: data, encoding: .utf8) {
                    print("Response data string:\n \(dataString)")
                }
        }
        task.resume()
        
    }
    
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()//.environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
