//
//  AddBackgroundView.swift
//  GithubContributions
//
//  Created by Kirtan Patel on 12/26/20.
//

import SwiftUI

struct AddBackgroundView: View {
    
    @Environment(\.managedObjectContext) var moc
    @Environment(\.presentationMode) var presentationMode
    @FetchRequest(entity: Palette.entity(), sortDescriptors: []) var palettes: FetchedResults<Palette>
    @FetchRequest(entity: AccColor.entity(), sortDescriptors: []) var accentColors: FetchedResults<AccColor>
    
    @ObservedObject var gen = ContributionGenerator()
    
    @State var showPicker = false
    
    @State var name = ""
    @State var palettePicker = 0
    @State var accentColorPicker = 0
    @State var isImage = false
    @State var lightMode: Color = .white
    @State var darkMode: Color = .black
    
    @State var customizeDarkMode = false
    
    @State var lightModeImage: UIImage? = nil
    @State var darkModeImage: UIImage? = nil
    @State var whichImage = false
    
//    @State var backgroundPreview: Background = Background()
    
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Preview")) {
                    VStack(alignment: .center){
                        ScrollView(.horizontal, showsIndicators: false) {
                            LazyHStack(spacing: 100) {
//                                ClassicGridWidget(background: backgroundPreview, light: palettes[palettePicker].lightColorArray, dark: palettes[palettePicker].darkColorArray, contribution: gen.contributions, totalContribution: 100, username: "user")
//                                    .frame(width:169, height: 169)
//                                    .cornerRadius(20)
//                                    .padding(.leading)
//
//                                CalendarWidget(background: backgroundPreview, light: palettes[palettePicker].lightColorArray, dark: palettes[palettePicker].darkColorArray, contribution: gen.contributions)
//                                    .frame(width:169, height: 169)
//                                    .cornerRadius(20)
//                                    .padding(.trailing)
                                
                            }
                        }
                    }.frame(maxWidth: .infinity)
                    .background(Color.red)
                    Picker("Palette", selection: $palettePicker) {
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
                    
                    Picker("Accent Colors", selection: $accentColorPicker) {
                        ForEach(0 ..< accentColors.count) { index in
                            HStack {
                                SplitCircle(colorOne: accentColors[index].wrappedLight, colorTwo: accentColors[index].wrappedDark, size: 10)
                                Text(accentColors[index].wrappedName)
                                    .padding(.leading, 10)
                            }
                        }
                    }
                }
                
                Section {
                    TextField("Name", text: $name)
                }
                
                Section(header: Text("Settings")) {
                    Toggle("Image Background", isOn: $isImage.animation())
                        .padding(.horizontal)
                    Toggle("Customize Dark Mode", isOn: $customizeDarkMode.animation())
                        .padding(.horizontal)
                }
//                .onChange(of: isImage) { state in
//                    <#code#>
//                }

                Section(header: Text("Customization")) {
                    if !isImage {
                        ColorPicker(customizeDarkMode ? "Light mode color" : "Background Color", selection: $lightMode)
                        if customizeDarkMode {
                            ColorPicker("Dark mode color", selection: $darkMode)
                        }
                    } else {
                        HStack {
                            if let light = lightModeImage {
                                Image(uiImage: light)
                                    .resizable()
                                    .frame(width: 20, height: 20)
                            }
                            
                            Button {
                                whichImage = false
                                showPicker.toggle()
                            } label: {
                                Text(customizeDarkMode ? "Pick light mode image" : "Pick background image")
                            }

                        }
                        if customizeDarkMode {
                            HStack {
                            if let dark = darkModeImage {
                                Image(uiImage: dark)
                                    .resizable()
                                    .frame(width: 20, height: 20)
                            }
                            
                            Button {
                                whichImage = true
                                showPicker.toggle()
                            } label: {
                                Text("Pick dark mode image")
                            }
                        }
                        }
                    }
                }
                
                Section {
                    Button("Add") {
                        
                        if name.isEmpty {
                            return
                        }
                        
                        let newBackground = Background(context: moc)
                        newBackground.id = UUID()
                        newBackground.date = Date()
                        newBackground.name = name
                        newBackground.isImage = isImage
                        
                        if customizeDarkMode {
                            newBackground.lightColor = lightMode.toData()
                            newBackground.darkColor = darkMode.toData()
                        } else {
                            newBackground.lightColor = lightMode.toData()
                            newBackground.darkColor = lightMode.toData()
                        }
                        
                        if isImage {
                            if let lImage = lightModeImage {
                                if customizeDarkMode {
                                    if let dImage = darkModeImage {
                                        newBackground.lightBackground = lImage.jpegData(compressionQuality: 0.5)
                                        newBackground.darkBackground = dImage.jpegData(compressionQuality: 0.5)
                                    }
                                } else {
                                    newBackground.lightBackground = lImage.jpegData(compressionQuality: 0.5)
                                    newBackground.darkBackground = lImage.jpegData(compressionQuality: 0.5)
                                }
                            } else {
                                return
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
            .onAppear {
                gen.generate()
//                backgroundPreview.id = UUID()
//                backgroundPreview.date = Date()
//                backgroundPreview.isImage = false
//                backgroundPreview.lightColor = lightMode.toData()
//                backgroundPreview.darkColor = darkMode.toData()
            }
            .navigationBarTitleDisplayMode(.inline)
            .navigationTitle("Add Background")
            .listStyle(InsetGroupedListStyle())
            .sheet(isPresented: $showPicker, content: {
                ImagePickerView(isPresented: $showPicker, selectedImage: whichImage ? $darkModeImage : $lightModeImage)
            })
        }
    }
}

struct AddBackgroundView_Previews: PreviewProvider {
    static var previews: some View {
        AddBackgroundView()
    }
}
