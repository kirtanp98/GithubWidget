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
    
    var body: some View {
        ZStack {
//            switch contribution.level {
//            case 0 :
//                Color.gray
//            case 1 :
//                Color.red
//            case 2 :
//                Color.pink
//            case 3 :
//                Color.blue
//            case 4 :
//                Color.green
//            default:
//                Color.gray
//            }
            colorPalett[contribution.level]
        }
        .frame(width: 10, height: 10)
        .cornerRadius(2)
    }
}

struct SquareView_Previews: PreviewProvider {
    static var previews: some View {
        SquareView(contribution: Contribute(date: Date(), level: 1, count: 2), colorPalett: [])
    }
}
