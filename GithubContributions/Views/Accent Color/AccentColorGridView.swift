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
    
    let columns = Array(repeating: GridItem.init(.flexible(), spacing: 5), count: 3) 
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns, alignment: .center, spacing: 10) {
                ForEach(accentColors, id: \.wrappedId) { item in
                    Menu {
                        Button("Edit", action: {})
                        Divider()
                        Button {
                            withAnimation {
                                self.moc.delete(item)

                                if self.moc.hasChanges{
                                    do{
                                        try self.moc.save()
                                    }catch{
                                        print("Error Saving")
                                    }
                                }
                            }
                        } label: {
                            Label("Delete", systemImage: "trash")
                        }
                    } label: {
                        VStack {
                            Text(item.wrappedName)
                                .foregroundColor(.gray)
                            SplitCircle(colorOne: item.wrappedLight, colorTwo: item.wrappedDark, size: 50)
                        }
                    }
                    .animation(.easeInOut)
                }
            }
        }.navigationTitle("Accent Color")
        .sheet(isPresented: $showModal, content: {
            AddAccentColorView()
                .environment(\.managedObjectContext, moc)
        })
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
