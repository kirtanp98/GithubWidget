//
//  BackgroundIcon.swift
//  GithubContributions
//
//  Created by Kirtan Patel on 1/16/21.
//

import SwiftUI

struct BackgroundIcon: View {
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 5)
                .foregroundColor(Color("indigo"))
                .frame(width: 30, height: 15)
            RoundedRectangle(cornerRadius: 5)
                .frame(width: 30, height: 15)
                .foregroundColor(Color("mint"))
                .clipShape(Triangle())
        }
    }
}

struct BackgroundIcon_Previews: PreviewProvider {
    static var previews: some View {
        BackgroundIcon()
    }
}
