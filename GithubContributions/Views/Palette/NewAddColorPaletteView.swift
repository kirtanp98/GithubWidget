//
//  NewAddColorPaletteView.swift
//  GithubContributions
//
//  Created by Kirtan Patel on 12/28/20.
//

import SwiftUI

struct NewAddColorPaletteView: View {
    
    @Environment(\.managedObjectContext) var moc
    @Environment(\.presentationMode) var presentationMode
    @FetchRequest(entity: Background.entity(), sortDescriptors: []) var backgrounds: FetchedResults<Background>

    @State var picker = 0
    @State var name = ""
    @State var customizeDarkMode = false
    @State var lightColors: [Color] = Color.githubGreen
    @State var darkColors: [Color] = Color.githubGreen

    
    var body: some View {
        NavigationView {
            Form {
                Section(footer:
                    HStack {
                        Spacer()
                        Text("Preview")
                        Spacer()
                    }
                ){
                    VStack(alignment: .center){
                        TabView {
                            Text("hi")
                                .font(.body)
                                .foregroundColor(.black)
                                .frame(width: 100, height: 150)
                                .background(Color.blue)
                            
                            Text("hi")
                                .font(.body)
                                .foregroundColor(.black)
                                .frame(width: 100, height: 150)
                                .background(Color.red)
                        }.tabViewStyle(PageTabViewStyle())
                    }.frame(maxWidth: .infinity)
                    .background(Color.red)
                    
                    Picker("Background", selection: $picker) {
                        ForEach(0 ..< backgrounds.count) { index in
                            HStack {
                                HStack(spacing: 10) {
                                    if backgrounds[index].isImage {
                                        Image(uiImage: backgrounds[index].wrappedLightBackground!)
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width: 30)
                                            .aspectRatio(contentMode: .fill)
                                            .frame(width: 30, height: 12)
                                            .cornerRadius(5)
                                            .clipped()

                                        Image(uiImage: backgrounds[index].wrappedDarkBackground!)
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width: 30)
                                            .aspectRatio(contentMode: .fill)
                                            .frame(width: 30, height: 12)
                                            .cornerRadius(5)
                                            .clipped()
                                    } else {
                                        RoundedRectangle(cornerRadius: 5)
                                            .frame(width: 30, height: 12)
                                            .foregroundColor(backgrounds[index].wrappedLightColor)
                                        
                                        RoundedRectangle(cornerRadius: 5)
                                            .frame(width: 30, height: 12)
                                            .foregroundColor(backgrounds[index].wrappedDarkColor)
                                    }
                                }
                                Text(backgrounds[index].wrappedName)
                                    .padding(.leading, 10)
                            }
                        }
                    }
                }
                
                Section {
                    TextField("Name", text: $name)
                }
                Section {
                    Toggle("Customize Dark Mode", isOn: $customizeDarkMode.animation(.easeInOut))
                        .padding(.horizontal)
                    Button("Randomize") {
                        for index in lightColors.indices {
                            let randomRed = Double.random(in: 0..<1)
                            let randomBlue = Double.random(in: 0..<1)
                            let randomGreen = Double.random(in: 0..<1)

                            let newColor = Color(red: randomRed, green: randomGreen, blue: randomBlue)
                            lightColors[index] = newColor
                        }
                        
                        if customizeDarkMode {
                            for index in darkColors.indices {
                                let randomRed = Double.random(in: 0..<1)
                                let randomBlue = Double.random(in: 0..<1)
                                let randomGreen = Double.random(in: 0..<1)

                                let newColor = Color(red: randomRed, green: randomGreen, blue: randomBlue)
                                darkColors[index] = newColor
                            }
                        }
                    }
                }
                
                Section {
                    VStack {
                        if customizeDarkMode {
                            Text("Light Mode")
                                .foregroundColor(.gray)
                                .font(.caption2)
                        } else {
                            Text("Normal")
                                .foregroundColor(.gray)
                                .font(.caption2)
                        }
                        
                        HStack {
                            ForEach(0..<5) { index in
                                Spacer()
                                VStack {
                                    ColorPicker("Pick Color", selection: $lightColors[index])
                                        .labelsHidden()
                                        .scaleEffect(CGSize(width: 2, height: 2))
                                        .frame(width: 50, height: 50)

                                    Text("Level \(index)")
                                        .foregroundColor(.gray)
                                        .font(.caption2)
                                }
                            }
                            Spacer()
                        }
                        
                    }
                }
                if customizeDarkMode {
                    
                    Section {
                        VStack {
                            Text("Dark Mode")
                                .foregroundColor(.gray)
                                .font(.caption2)
                            HStack {
                                ForEach(0..<5) { index in
                                    Spacer()
                                    VStack{
                                        ColorPicker("Pick Color", selection: $darkColors[index])
                                            .labelsHidden()
                                            .scaleEffect(CGSize(width: 2, height: 2))
                                            .frame(width: 50, height: 50)
                                        Text("Level \(index)")
                                            .foregroundColor(.gray)
                                            .font(.caption2)
                                    }
                                }
                                Spacer()
                            }
                        }
                    }.animation(.easeInOut)

                }
                
                Section {
                    Button("Add") {
                        
                        if name.isEmpty {
                            return
                        }
                        
                        let newPalette = Palette(context: moc)
                        newPalette.id = UUID()
                        newPalette.date = Date()
                        newPalette.name = name
                        
                        for index in (0..<5) {
                            let colorP = CColor(context: moc)
                            colorP.id = UUID()
                            colorP.level = Int16(index)
                            colorP.origin = newPalette
                            
                            if customizeDarkMode {
                                colorP.light = lightColors[index].toData()
                                colorP.dark = darkColors[index].toData()
                            } else {
                                colorP.light = lightColors[index].toData()
                                colorP.dark = lightColors[index].toData()

                            }
                            
                        }

                        if self.moc.hasChanges{
                            do{
                                try self.moc.save()
                                self.presentationMode.wrappedValue.dismiss()
                            }catch{
                                print("Error Saving")
                            }
                        }
                    }
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .navigationTitle("Add Palette")
            .listStyle(InsetGroupedListStyle())
        }
    }
}

struct NewAddColorPaletteView_Previews: PreviewProvider {
    static var previews: some View {
        NewAddColorPaletteView()
    }
}
