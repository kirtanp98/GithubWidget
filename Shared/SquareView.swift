//
//  SquareView.swift
//  GithubContributions
//
//  Created by Kirtan Patel on 12/19/20.
//

import SwiftUI

struct SquareView: View {
    
    @Environment(\.colorScheme) var colorScheme
    
    var contribution: Contribute
    var lightColorPalette: [Color]
    var darkColorPalette: [Color]
    var size: CGFloat
    var border: Bool = false
    
    var body: some View {
        ZStack {
            colorScheme == .dark ? darkColorPalette[contribution.level] : lightColorPalette[contribution.level]
        }
        .frame(width: size, height: size)
        .cornerRadius(border ? 2 : 0)
    }
}

struct SquareView_Previews: PreviewProvider {
    static var previews: some View {
        SquareView(contribution: Contribute(date: Date(), level: 1, count: 2), lightColorPalette: [], darkColorPalette: [], size: 10)
    }
}
