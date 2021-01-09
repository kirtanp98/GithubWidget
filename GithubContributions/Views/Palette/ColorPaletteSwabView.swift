//
//  ColorPaletteSwab.swift
//  GithubContributions
//
//  Created by Kirtan Patel on 12/23/20.
//

import SwiftUI

struct ColorPaletteSwabView: View {
    
    @Environment(\.managedObjectContext) var moc
    
    @FetchRequest(entity: Palette.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \Palette.date, ascending: false)]) var palettes: FetchedResults<Palette>
    
    @State var showModal = false
    
    var body: some View {
        List {            
            ForEach(palettes) { pal in
                PaletteView(palette: pal)
            }.onDelete(perform: delete)
            
        }
        .navigationTitle("Color Palettes")
        .sheet(isPresented: $showModal, content: {
            NewAddColorPaletteView()
                .environment(\.managedObjectContext, moc)
        })
        .toolbar {
            ToolbarItem(placement: .primaryAction) {
                Button {
                    withAnimation {
                        showModal.toggle()
                    }
                } label: {
                    Image(systemName: "plus")
                }

            }
        }
    }
    
    func delete(at offsets: IndexSet) {
        offsets.forEach { index in
            let elementToDelete = palettes[index]
            self.moc.delete(elementToDelete)
        }
        
        if self.moc.hasChanges{
            do{
                try self.moc.save()
            }catch{
                print("Error Saving")
            }
        }
    }
}

struct ColorPaletteSwabView_Previews: PreviewProvider {
    static var previews: some View {
        ColorPaletteSwabView()
    }
}
