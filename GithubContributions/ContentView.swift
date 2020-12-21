//
//  ContentView.swift
//  GithubContributions
//
//  Created by Kirtan Patel on 12/19/20.
//x

import SwiftUI
import CoreData

struct ContentView: View {
    
    var body: some View {
        NavigationView {
            List {
                Section {
                    Label("Authenticate with GitHub", systemImage: "person.fill")
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
        }
    }
    
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()//.environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
