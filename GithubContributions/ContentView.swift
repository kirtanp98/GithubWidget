//
//  ContentView.swift
//  GithubContributions
//
//  Created by Kirtan Patel on 12/19/20.
//

import SwiftUI
import CoreData

struct ContentView: View {

    var body: some View {
        Text("Hello")
    }

}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()//.environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
