//
//  ContentView.swift
//  GithubContributions
//
//  Created by Kirtan Patel on 12/19/20.
//x

import SwiftUI
import CoreData

struct ContentView: View {
    
    @State var contribution: [Contribution] = []
    let grid = [GridItem(.fixed(10)),
                GridItem(.fixed(10)),
                GridItem(.fixed(10)),
                GridItem(.fixed(10)),
                GridItem(.fixed(10)),
                GridItem(.fixed(10)),
                GridItem(.fixed(10))]
    
    var body: some View {
        VStack {
            ScrollView(.horizontal) {
                LazyHGrid(rows: grid, spacing: 10) {
                    ForEach(contribution, id: \.date){ con  in
                        Text("\(con.level)")
                            .background(Color.green)
                    }
                }
            }
            
            Text("Hello")
                .onAppear{
                    contribution = try! GitHub.loadDataToApp()
                }
        }
    }
    
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()//.environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
