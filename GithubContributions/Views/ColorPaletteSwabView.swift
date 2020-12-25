//
//  ColorPaletteSwab.swift
//  GithubContributions
//
//  Created by Kirtan Patel on 12/23/20.
//

import SwiftUI

struct ColorPaletteSwabView: View {
    
    @Environment(\.managedObjectContext) var moc
    @EnvironmentObject var modalController: ModalController
    
    @FetchRequest(entity: Palette.entity(), sortDescriptors: []) var palettes: FetchedResults<Palette>
    
    var body: some View {
        List {            
            ForEach(palettes) { pal in
                PaletteView(palette: pal)
            }.onDelete(perform: delete)
            
        }.navigationTitle("Color Palettes")
        .toolbar {
            ToolbarItem(placement: .primaryAction) {
                Button {
                    withAnimation {
                        modalController.toggleModal()
                    }
                    
//                    let new = Palette(context: moc)
//                    new.date = Date()
//                    new.id = UUID()
//                    new.name = "Test"
//                    print("add")
//
//                    if self.moc.hasChanges{
//                        do{
//                            try self.moc.save()
//                        }catch{
//                            print("Error Saving")
//                        }
//                    }
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
