//
//  ClassicGridWidget.swift
//  GithubContributions
//
//  Created by Kirtan Patel on 1/5/21.
//

import SwiftUI
import KingfisherSwiftUI

struct ClassicGridWidget: View {
    
    @Environment(\.colorScheme) var colorScheme
    
    var background: Background?
    
    var light: [Color]
    var dark: [Color]
    
    @State var width: CGFloat = 1
    @State var height: CGFloat = 1
    @State var remain: CGFloat = 1
    
    @State var totalSquares: Int = 1
    
    @State var contribution: [Contribute]
    
    @State var columns = [
        GridItem(.fixed(1)),
    ]
    
    private let ratio: CGFloat = 0.20
    private let spacing: CGFloat = 0.1
    
    var body: some View {
        GeometryReader { geometry in
            
            ZStack {
                if let back = background {
                    if back.isImage {

                        if colorScheme == .dark {
                            Image(uiImage: back.wrappedDarkBackground!)
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: geometry.size.width)
                                .clipped()
                        } else {
                            Image(uiImage: back.wrappedLightBackground!)
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: geometry.size.width)
                                .clipped()
                        }

                    } else {
                        colorScheme == .dark ? back.wrappedDarkColor : back.wrappedLightColor
                    }
                }
                
                VStack(alignment: .center, spacing: 0) {
                    HStack {
                        KFImage(URL(string: "https://avatars0.githubusercontent.com/u/28634279?u=465dcd4d6b590ff241c6257bd4baf7134264ea39&v=4")!)
                            .resizable()
                            .frame(width: (geometry.size.height * 0.12), height: (geometry.size.height * 0.12))
                        //https://avatars0.githubusercontent.com/u/28634279?u=465dcd4d6b590ff241c6257bd4baf7134264ea39&v=4
                        Text("Kirtan Patel")
                            .font(.caption)
                            .foregroundColor(.gray)
                        Spacer()
                        if geometry.size.width > 169 {
                            Text("\(100) contributions")
                                .font(.caption)
                                .foregroundColor(.gray)
                        }
                    }
                    .frame(height: remain * ratio)
                    LazyHGrid(rows: columns, alignment: .center, spacing: 2){
                        ForEach(contribution.suffix(totalSquares), id: \.date) { item in
                            if item.empty {
                                EmptyView().frame(width: (height/7) - 2, height: (height/7) - 2)
                            } else {
                                ZStack {
                                    SquareView(contribution: item, lightColorPalette: light, darkColorPalette: dark, size: (height/7) - 2)
                                        .cornerRadius(3)
                                                                        
//                                    RoundedRectangle(cornerRadius: 3)
//                                        .strokeBorder(Color.gray.opacity(0.2),lineWidth: 1)
//                                        .frame(width: (height/7) - 2, height: (height/7) - 2)
                                }
                            }
                                
                        }
                    }
                        .frame(height: remain * (1-ratio))
                    Spacer().frame(height: geometry.size.height * spacing)
                }
                .frame(width: width * 0.9)
                .onAppear {
                    remain = geometry.size.height - (geometry.size.height * spacing)
                    width = geometry.size.width * 0.9
                    height = remain * (1-ratio)
                    
                    let squareLength = floor(height/7)
                    
                    totalSquares = Int(7 * floor(width/(squareLength)))
                    
                    columns = Array(repeating: GridItem(.flexible(), spacing: 2, alignment: .center), count: 7)
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
    }
}

struct ClassicGridWidget_Previews: PreviewProvider {
    static var previews: some View {
        ClassicGridWidget(light: Color.githubGreen, dark: Color.githubGreen, contribution: [])
    }
}
