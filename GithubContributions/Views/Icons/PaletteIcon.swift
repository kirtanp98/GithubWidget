//
//  PaletteIconView.swift
//  GithubContributions
//
//  Created by Kirtan Patel on 1/16/21.
//

import SwiftUI

struct PaletteIcon: View {
    var body: some View {
        ZStack {
            Circle()
                .foregroundColor(Color("indigo"))
                .offset(x: 10, y: -10)
            Circle()
                .foregroundColor(Color("mint"))
            Circle()
                .foregroundColor(Color("cerise"))
                .offset(x: -10, y: 10)
        }
    }
}

struct PaletteIconView_Previews: PreviewProvider {
    static var previews: some View {
        PaletteIcon()
    }
}
