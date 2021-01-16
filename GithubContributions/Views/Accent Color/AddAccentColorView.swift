//
//  AddAccentColorView.swift
//  GithubContributions
//
//  Created by Kirtan Patel on 1/9/21.
//

import SwiftUI

struct AddAccentColorView: View {
    
    @Environment(\.managedObjectContext) var moc
    @Environment(\.presentationMode) var presentationMode
    
    @FetchRequest(entity: Palette.entity(), sortDescriptors: []) var palettes: FetchedResults<Palette>
    @FetchRequest(entity: Background.entity(), sortDescriptors: []) var backgrounds: FetchedResults<Background>
    
    @ObservedObject var gen = ContributionGenerator()
        
    @State var name = ""
    @State var colorPicker = 0
    @State var backgroundPicker = 0
    @State var customizeDarkMode = false
    
    @State var lightMode: Color = .gray
    @State var darkMode: Color = .gray
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Preview")) {
                    VStack(alignment: .center){
                        ScrollView(.horizontal, showsIndicators: false) {
                            LazyHStack(spacing: 100) {
                                ClassicGridWidget(background: backgrounds[backgroundPicker], light: palettes[colorPicker].lightColorArray, dark: palettes[colorPicker].darkColorArray, contribution: gen.contributions, totalContribution: 100, username: "user")
                                    .frame(width:169, height: 169)
                                    .cornerRadius(20)
                                    .padding(.leading)

                                CalendarWidget(background: backgrounds[backgroundPicker], light: palettes[colorPicker].lightColorArray, dark: palettes[colorPicker].darkColorArray, contribution: gen.contributions)
                                    .frame(width:169, height: 169)
                                    .cornerRadius(20)
                                    .padding(.trailing)
                                
                            }
                        }
                    }.frame(maxWidth: .infinity)
                    .padding(.vertical)
                    
                    Picker("Palette", selection: $colorPicker) {
                        ForEach(0 ..< palettes.count) { index in
                            HStack {
                                HStack {
                                    ForEach(palettes[index].colorArray, id: \.wrappedLevel) { pal in
                                        SplitCircle(colorOne: pal.wrappedLightColor, colorTwo: pal.wrappedDarkColor, size: 10)
                                    }
                                }
                                Text(palettes[index].wrappedName)
                                    .padding(.leading, 10)
                            }
                        }
                    }
                    Picker("Background", selection: $backgroundPicker) {
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
                
                Section(header: Text("Settings")) {
                    Toggle("Customize Dark Mode", isOn: $customizeDarkMode.animation())
                        .padding(.horizontal)
                }
                
                Section(header: Text("Accent Colors")) {
                    ColorPicker(customizeDarkMode ? "Light mode color" : "Accent Color", selection: $lightMode)
                    if customizeDarkMode {
                        ColorPicker("Dark mode color", selection: $darkMode)
                    }
                }
                
                Section {
                    Button("Add") {
                        if name.isEmpty {
                            return
                        }
                        
                        let newAccentColor = AccColor(context: moc)
                        newAccentColor.name = name
                        newAccentColor.date = Date()
                        newAccentColor.id = UUID()
                        
                        if customizeDarkMode {
                            newAccentColor.light = lightMode.toData()
                            newAccentColor.dark = darkMode.toData()
                        } else {
                            newAccentColor.light = lightMode.toData()
                            newAccentColor.dark = lightMode.toData()
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
            .navigationTitle("Add Accent Color")
            .listStyle(InsetGroupedListStyle())
            .onAppear {
                gen.generate()
                print("generating")
            }

        }
    }
}

struct AddAccentColorView_Previews: PreviewProvider {
    static var previews: some View {
        AddAccentColorView()
    }
}
