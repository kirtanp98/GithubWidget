//
//  AddBackgroundView.swift
//  GithubContributions
//
//  Created by Kirtan Patel on 12/26/20.
//

import SwiftUI

struct AddBackgroundView: View {
    
    @State var showPicker = false
    
    @State var name = ""
    @State var isImage = false
    @State var lightMode: Color = .white
    @State var darkMode: Color = .black
    
    @State var lightModeImage: UIImage? = nil
    @State var darkModeImage: UIImage? = nil
    @State var whichImage = false
    
    
    var body: some View {
        
        Form {
            Section(header:
                        VStack(alignment: .center){
                            Text("hi")
                                .font(.body)
                                .foregroundColor(.black)
                                .frame(width: 100, height: 150)
                                .background(Color.blue)
                        }.frame(maxWidth: .infinity)
                        .background(Color.red)
                    , footer:
                        VStack(alignment: .center) {
                            Text("Preview")
                        }.frame(maxWidth: .infinity)
            ) {
                EmptyView()
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
                    print("add")
                }
            }
                
        }
        .listStyle(InsetGroupedListStyle())
        .sheet(isPresented: $showPicker, content: {
            ImagePickerView(isPresented: $showPicker, selectedImage: whichImage ? $darkModeImage : $lightModeImage)
        })
    }
}

struct AddBackgroundView_Previews: PreviewProvider {
    static var previews: some View {
        AddBackgroundView()
    }
}
