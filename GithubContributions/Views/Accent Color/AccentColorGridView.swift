//
//  AccentColorGridView.swift
//  GithubContributions
//
//  Created by Kirtan Patel on 1/9/21.
//

import SwiftUI

struct AccentColorGridView: View {
    
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(entity: AccColor.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \AccColor.date, ascending: false)]) var accentColors: FetchedResults<AccColor>
    
    @State var showModal = false
    
    let columns = [GridItem(.adaptive(minimum: 0)), GridItem(.adaptive(minimum: 0)), GridItem(.adaptive(minimum: 0))]
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns, alignment: .center, spacing: 0) {
                ForEach(accentColors, id: \.wrappedId) { item in
                    SplitCircle(colorOne: item.wrappedLight, colorTwo: item.wrappedDark, size: 50)
                }
            }
        }.navigationTitle("Accent Color")
        .toolbar {
            ToolbarItem(placement: .primaryAction) {
                Button {
                        showModal.toggle()
                } label: {
                    Image(systemName: "plus")
                }

            }
        }
    }
}

struct AccentColorGridView_Previews: PreviewProvider {
    static var previews: some View {
        AccentColorGridView()
    }
}
