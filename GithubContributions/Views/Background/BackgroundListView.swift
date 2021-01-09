//
//  BackgroundListView.swift
//  GithubContributions
//
//  Created by Kirtan Patel on 12/23/20.
//

import SwiftUI

struct BackgroundListView: View {
    
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(entity: Background.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \Background.date, ascending: false)]) var backgrounds: FetchedResults<Background>
    
    @State var showModal = false
    
    var body: some View {
        List {
            ForEach(backgrounds, id: \.wrappedID) { background in
                BackgroundItem(background: background)
            }.onDelete(perform: delete)
        }.navigationTitle("Backgrounds")
        .sheet(isPresented: $showModal, content: {
            AddBackgroundView()
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
    
    func delete(at offsets: IndexSet) {
        offsets.forEach { index in
            let elementToDelete = backgrounds[index]
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

struct BackgroundItem: View {
    
    var background: Background
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(background.wrappedName)
                .foregroundColor(.gray)
            HStack {
                Spacer()
                ZStack {
                    
                    if background.isImage {
                        Image(uiImage: background.wrappedLightBackground!)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 300)
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 300, height: 120)
                            .cornerRadius(10)
                            .clipped()
                        
                        Image(uiImage: background.wrappedDarkBackground!)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 300)
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 300, height: 120)
                            .cornerRadius(10)
                            .clipped()
                            .clipShape(Triangle())

                        
                    } else {
                        RoundedRectangle(cornerRadius: 10)
                            .frame(width: 300, height: 120)
                            .foregroundColor(background.wrappedLightColor)
                        
                        RoundedRectangle(cornerRadius: 10)
                            .frame(width: 300, height: 120)
                            .foregroundColor(background.wrappedDarkColor)
                            .clipShape(Triangle())
                    }
                }
                    .shadow(radius: 2)
                Spacer()
            }
        }
        .padding(.bottom, 10)
    }
}

struct Triangle: Shape {
    func path(in rect: CGRect) -> Path {
            var path = Path()

            path.move(to: CGPoint(x: rect.minX, y: rect.minY))
            path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
            path.addLine(to: CGPoint(x: rect.maxX, y: rect.minY))
            path.addLine(to: CGPoint(x: rect.minX, y: rect.minY))

            return path
        }
}

struct BackgroundListView_Previews: PreviewProvider {
    static var previews: some View {
        BackgroundListView()
    }
}
