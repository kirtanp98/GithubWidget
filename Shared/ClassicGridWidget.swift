//
//  ClassicGridWidget.swift
//  GithubContributions
//
//  Created by Kirtan Patel on 1/5/21.
//

import SwiftUI

struct ClassicGridWidget: View {
    
    @Environment(\.colorScheme) var colorScheme
    
    var background: Background?
    
    var light: [Color]
    var dark: [Color]
    
    @State var width: CGFloat = 1
    @State var height: CGFloat = 1
    
    @State var totalSquares: Int = 1
    
    @State var contribution: [Contribute]
    
    @State var columns = [
        GridItem(.fixed(1)),
    ]
    
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
                
                VStack(alignment: .center) {
                    LazyHGrid(rows: columns, alignment: .center, spacing: 2){
                        ForEach(contribution.suffix(totalSquares), id: \.date) { item in
                            if item.empty {
                                EmptyView().frame(width: (height/7) - 2, height: (height/7) - 2)
                            } else {
                                ZStack {
                                    SquareView(contribution: item, lightColorPalette: light, darkColorPalette: dark, size: (height/7) - 2)
                                        .cornerRadius(3)
                                    RoundedRectangle(cornerRadius: 3)
                                        .strokeBorder(Color.gray.opacity(0.2),lineWidth: 2)
                                        .frame(width: (height/7) - 2, height: (height/7) - 2)
                                }
                            }
                                
                        }
                    }
                }.onAppear {
                    width = geometry.size.width
                    height = geometry.size.height
                    
                    let squareLength = floor(height/7)
                    
                    totalSquares = Int(7 * floor(width/(squareLength)))
                    
                    columns = Array(repeating: GridItem(.flexible(), spacing: 2, alignment: .center), count: 7)
                }
            }
        }
    }
}

struct ClassicGridWidget_Previews: PreviewProvider {
    static var previews: some View {
        ClassicGridWidget(light: Color.githubGreen, dark: Color.githubGreen, contribution: [])
    }
}
