//
//  CalendarWidget.swift
//  GithubContributions
//
//  Created by Kirtan Patel on 12/28/20.
//

import SwiftUI

struct CalendarWidget: View {
    
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
    
    @State var finishedRender = false
    
    var body: some View {
        GeometryReader { geometry in
            
            ZStack {
                if finishedRender {
                    BackgroundWidgetView(background: background, width: geometry.size.width, height: geometry.size.height)
                    
                    VStack(alignment: .center) {
                        LazyHGrid(rows: columns, alignment: .center, spacing: 0){
                            ForEach(contribution.suffix(totalSquares), id: \.date) { item in
                                SquareView(contribution: item, lightColorPalette: light, darkColorPalette: dark, size: (height/7))
                            }
                        }
                    }.frame(width: geometry.size.width, height: geometry.size.height)
                }
            }
            .onAppear {
                width = geometry.size.width
                height = geometry.size.height
                
                let squareLength = floor(height/7)
                
                totalSquares = Int(7 * floor(width/(squareLength)))
                
                columns = Array(repeating: GridItem(.flexible(), spacing: 0, alignment: .center), count: 7)
                finishedRender = true
            }
        }
    }
}

struct CalendarWidget_Previews: PreviewProvider {
    static var previews: some View {
        CalendarWidget(light: [], dark: [], contribution: [])
    }
}
