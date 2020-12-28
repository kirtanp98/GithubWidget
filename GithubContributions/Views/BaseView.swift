//
//  BaseView.swift
//  GithubContributions
//
//  Created by Kirtan Patel on 12/24/20.
//

import SwiftUI

struct BaseView: View {
    @Environment(\.colorScheme) var colorScheme

    var body: some View {
        ZStack {
            ContentView()
        }
    }
}

struct BaseView_Previews: PreviewProvider {
    static var previews: some View {
        BaseView()
    }
}
