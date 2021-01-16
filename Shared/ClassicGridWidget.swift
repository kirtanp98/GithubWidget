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
    @State var totalContribution: Int
    @State var userProfileURL: String = "https://avatars0.githubusercontent.com/u/28634279?u=465dcd4d6b590ff241c6257bd4baf7134264ea39&v=4"
    @State var username: String
    @State var showDetails = true
    
    @State var columns = Array(repeating: GridItem(.flexible(), spacing: 2, alignment: .center), count: 7)
    
    private let ratio: CGFloat = 0.20
    private let spacing: CGFloat = 0.1
    
    @State var finishedRender = false
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                if finishedRender {
                    ZStack {
                        BackgroundWidgetView(background: background, width: geometry.size.width, height: geometry.size.height)
                        
                        VStack(alignment: .center, spacing: 0) {
                            if showDetails {
                                HStack(spacing: 5) {
                                    KFImage(URL(string: userProfileURL)!)
                                        .resizable()
                                        .frame(width: (geometry.size.height * 0.11), height: (geometry.size.height * 0.11))
                                        .clipShape(Circle())
                                    Text(username)
                                        .font(.caption)
                                        .foregroundColor(.gray)
                                    Spacer()
                                    if geometry.size.width > 169 {
                                        Text("\(totalContribution) contributions")
                                            .font(.caption)
                                            .foregroundColor(.gray)
                                    }
                                }
                                .frame(height: remain * ratio)
                            }
                            LazyHGrid(rows: columns, alignment: .center, spacing: 2){
                                ForEach(contribution.suffix(totalSquares), id: \.date) { item in
                                    if item.empty {
                                        EmptyView().frame(width: (height/7) - 2, height: (height/7) - 2)
                                    } else {
                                        ZStack {
                                            SquareView(contribution: item, lightColorPalette: light, darkColorPalette: dark, size: (height/7) - 2)
                                                .cornerRadius(3)
                                        }
                                    }
                                    
                                }
                            }
                            .frame(height: showDetails ? remain * (1-ratio) : remain)
//                            .frame(height: remain)// * (1-ratio))
                            if showDetails {
                                Spacer().frame(height: geometry.size.height * spacing)
                            }
                        }
                        .frame(width: width * 0.9)
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                }
            }
            .onAppear {
                remain = geometry.size.height - (geometry.size.height * spacing)
                width = geometry.size.width * 0.9
            
                height = showDetails ? remain * (1-ratio) : remain
                
                let squareLength = floor(height/7)
                
                totalSquares = Int(7 * floor(width/(squareLength)))
                
                finishedRender = true
            }
            
        }
        
    }
}

struct ClassicGridWidget_Previews: PreviewProvider {
    static var previews: some View {
        ClassicGridWidget(light: Color.githubGreen, dark: Color.githubGreen, contribution: [], totalContribution: 100, userProfileURL: "", username: "")
    }
}
