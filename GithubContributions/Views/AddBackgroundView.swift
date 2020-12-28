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
    
    @State var showPicker = false
    
    @State var name = ""
    @State var picker = 0
    @State var isImage = false
    @State var lightMode: Color = .white
    @State var darkMode: Color = .black
    
    @State var lightModeImage: UIImage? = nil
    @State var darkModeImage: UIImage? = nil
    @State var whichImage = false
    
    
    var body: some View {
        NavigationView {
            Form {
                
                Section {
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
                    Picker("Palette", selection: $picker) {
                        ForEach(0 ..< palettes.count) { index in
                            HStack {
                                HStack {
                                    ForEach(palettes[index].colorArray.reversed(), id: \.wrappedLevel) { pal in
                                        SplitCircle(colorOne: pal.wrappedLightColor, colorTwo: pal.wrappedDarkColor, size: 10)
                                    }
                                }
                                Text(palettes[index].wrappedName)
                                    .padding(.leading, 10)
                            }
                        }
                    }
                }
                
                Section {
                    TextField("Name", text: $name)
                }
                
                Section {
                    Toggle("Image Background", isOn: $isImage.animation())
                }
                
                Section {
                    if !isImage {
                        ColorPicker("Light mode color", selection: $lightMode)
                        ColorPicker("Dark mode color", selection: $darkMode)
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
                                Text("Pick light mode image")
                            }

                        }
                        
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
                        newBackground.lightColor = lightMode.toData()
                        newBackground.darkColor = darkMode.toData()
                        
                        if isImage {
                            if let lImage = lightModeImage, let dImage = darkModeImage {
                                newBackground.lightBackground = lImage.jpegData(compressionQuality: 0.5)
                                newBackground.darkBackground = dImage.jpegData(compressionQuality: 0.5)
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
