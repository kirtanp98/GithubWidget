//
//  AddColorPaletteView.swift
//  GithubContributions
//
//  Created by Kirtan Patel on 12/24/20.
//

import SwiftUI

struct AddColorPaletteView: View {
    
    @EnvironmentObject var modalController: ModalController

    @State var customizeDarkMode = false
    @State var level0Light = Color.green
    @State var name = ""
//    @State var colors: [Color] = [.white,.white,.white,.white,.white,.white,.white,.white,.white,.white,]
    @State var lightColors: [Color] = Color.githubGreen
    @State var darkColors: [Color] = Color.githubGreen
    
    var body: some View {
        VStack {
            VStack {
                TextField("Palette Name", text: $name)
                    .multilineTextAlignment(.center)
//                    .fontWeight(.semibold)
//                    .font(.title)
                    .font(Font.title.weight(.semibold))
                    .padding(.bottom)
//                Text("Add a Palette")
                VStack {
                    Text("Preview")
                        .font(.caption)
                        .fontWeight(.light)
                        .foregroundColor(.gray)
                    TabView {
                        Text("Preview goes here")
                        Text("Preview goes here")
                    }.tabViewStyle(PageTabViewStyle())
                }
                .frame(height: 200)
                .background(Color(UIColor.tertiarySystemBackground))
                .cornerRadius(10)
//                DisclosureGroup("Backgrounds") {
//                    Text("HMM")
//                }.padding(.horizontal)
//                .background(Color(UIColor.tertiarySystemBackground))
                
                Toggle("Customize Dark Mode", isOn: $customizeDarkMode.animation(.easeInOut))
                    .padding(.horizontal)
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
//                            Circle()
//                                .frame(width: 50, height: 50)
                            VStack {
                                ColorPicker("Pick Color", selection: $lightColors[index])
                                    .labelsHidden()
                                Text("Level \(index)")
                                    .foregroundColor(.gray)
                                    .font(.caption2)
                            }
                        }
                        Spacer()
                    }.padding(customizeDarkMode ? .bottom : [])
                    
                    if customizeDarkMode {
                        Text("Dark Mode")
                            .foregroundColor(.gray)
                            .font(.caption2)
                        HStack {
                            ForEach(0..<5) { index in
                                Spacer()
                                VStack{
                                    ColorPicker("Pick Color", selection: $darkColors[index])
                                        .labelsHidden()
                                    Text("Level \(index)")
                                        .foregroundColor(.gray)
                                        .font(.caption2)
                                }
                            }
                            Spacer()
                        }.transition(.move(edge: .top))
                    }
                }
                .padding(.vertical)
                
                Button {
                    print("hi")
                    withAnimation {
                        modalController.dismissModal()
                    }
                } label: {
                    Text("Add")
                        .bold()
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .frame(height: 40)
                        .background(Color.blue)
                        .cornerRadius(10)
                        .padding(.horizontal)
                }

            }
            .padding(.vertical)
            .frame(maxWidth: .infinity)
            .background(Color(UIColor.secondarySystemBackground))
            .cornerRadius(10)
            .padding()
            .ignoresSafeArea(.keyboard, edges: .bottom)

        }
    }
}

struct AddColorPaletteView_Previews: PreviewProvider {
    static var previews: some View {
        AddColorPaletteView()
    }
}
