//
//  ContentView.swift
//  GithubContributions
//
//  Created by Kirtan Patel on 12/19/20.
//x

import SwiftUI
import CoreData
import BetterSafariView
import KingfisherSwiftUI

struct ContentView: View {
    
    @EnvironmentObject var authManager: AuthManager
    @State var showAuthLogin = false
    
    @ObservedObject var userFetcher = UserContributionFetcher()
    
    @Environment(\.managedObjectContext) var moc
    
    var body: some View {
        NavigationView {
            List {
                Section {
                    if authManager.offline {
                        VStack(alignment: .center) {
                            Text("Offline")
                                .bold()
                                .foregroundColor(.red)
                            Text("Please be connected to the internet and restart the app")
                                .font(.caption)
                                .foregroundColor(.gray)
                        }
                    }
                    else if !authManager.loginedIn {
                        Button(action: {
                            withAnimation(.easeIn) {
                                showAuthLogin.toggle()
                            }
                        }){
                            Label("Authenticate with GitHub", systemImage: "person.fill")
                        }
                    }
                    else {
                        HStack {
                            if let url = URL(string: authManager.imageURL) {
                                KFImage(url)
                                    .resizable()
                                    .clipShape(Circle())
                                    .frame(width: 40, height: 40)
                                    .animation(.easeInOut)
                            }
                            Text("Hi, \(authManager.userName)")
                                .bold()
                                .animation(.easeInOut)

                            Spacer()
                            Button(action: {
                                withAnimation(.easeOut) {
                                    authManager.logOut()
                                }
                            }) {
                                Text("Logout")
                            }
                        }

                    }
                }
                
                Section(header: Text("Stylize")) {
                    NavigationLink(destination: ColorPaletteSwabView()) {
                        Label {
                            Text("Color Palette")
                         } icon: {
                            Image(systemName: "sparkles")
                                .renderingMode(.original)
                        }
                    }
                    
                    NavigationLink(destination: BackgroundListView()) {
                        Label {
                            Text("Background")
                         } icon: {
                            Image(systemName: "sparkles")
                                .renderingMode(.original)
                        }
                    }
                }
                
                Section(header: Text("Tip")) {
                    Label {
                        Text("$0.99 Tip")
                     } icon: {
                        Image(systemName: "gift.fill")
                            .renderingMode(.original)
                    }
                    Label {
                        Text("$2.99 Tip")
                     } icon: {
                        Image(systemName: "gift.fill")
                            .renderingMode(.original)
                    }
                    Label {
                        Text("$5.99 Tip")
                     } icon: {
                        Image(systemName: "gift.fill")
                            .renderingMode(.original)
                    }
                    Button("Restore Purchases") {
                        print("restoring")
                    }
                }
                
                Section(header: Text("Contact")) {
                    Link(destination: URL(string: "https://twitter.com/Kirtanisnothere")!) {
                        Label {
                            Text("@Kirtanisnothere")
                                .bold()
                         } icon: {
                            Image("twitter")
                                .resizable()
                                .scaledToFit()
                        }
                    }
                }
                
                Section {
//                    Text("\(wid.calendar.weeks.count)")
                    if !userFetcher.loading {
                        ClassicGridWidget(light: Color.githubGreen, dark: Color.githubGreen, contribution: userFetcher.contributions)
                        .frame(width: 164, height: 155)//329x155
                    }
                }
                
            }
            .onAppear {
                userFetcher.fetchData(user: "kirtanp98")
            }
            .listStyle(InsetGroupedListStyle())
            .navigationTitle("Contributions")
            .webAuthenticationSession(isPresented: $showAuthLogin) {
                WebAuthenticationSession(
                    url: URL(string: "https://github.com/login/oauth/authorize?client_id=4254465c6344b733f4a6&allow_signup=true")!,
                    callbackURLScheme: "widgets://"
                ) { callbackURL, error in
                    if let urlString = callbackURL {
                        makePostRequet(urlString.absoluteString)
                    }
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
                    let sep = dataString.components(separatedBy: "=")
                    let accessToken = sep[1].split(separator: "&")[0]
                    print(accessToken)
                    
                    DispatchQueue.main.async {
                        authManager.updateStatus(authKey: String(accessToken))
                    }
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
