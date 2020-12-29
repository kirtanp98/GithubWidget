//
//  SquareView.swift
//  GithubContributions
//
//  Created by Kirtan Patel on 12/19/20.
//

import SwiftUI

struct SquareView: View {
    var contribution: Contribute
    var colorPalett: [Color]
    var size: CGFloat
    
    var body: some View {
        ZStack {
            colorPalett[contribution.level]
        }
        .frame(width: size, height: size)
        //.border(Color.white, width: 1)
//        .cornerRadius(2)
    }
}

struct SquareView_Previews: PreviewProvider {
    static var previews: some View {
        SquareView(contribution: Contribute(date: Date(), level: 1, count: 2), colorPalett: [], size: 10)
    }
}
