//
//  BackgroundWidgetView.swift
//  GithubContributions
//
//  Created by Kirtan Patel on 1/13/21.
//

import SwiftUI

struct BackgroundWidgetView: View {
    
    @Environment(\.colorScheme) var colorScheme
    
    var background: Background?
    
    @State var width: CGFloat
    @State var height: CGFloat
    
    var body: some View {
        ZStack {
            if let back = background {
                if back.isImage {
                    if colorScheme == .dark {
                        Image(uiImage: back.wrappedDarkBackground!)
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(maxWidth: .infinity)
                            .clipped()
                    } else {
                        Image(uiImage: back.wrappedLightBackground!)
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(maxWidth: .infinity)
                            .clipped()
                    }
                } else {
                    colorScheme == .dark ? back.wrappedDarkColor : back.wrappedLightColor
                }
            }
        }
        .frame(width: width, height: height)
    }
}

//struct BackgroundWidgetView_Previews: PreviewProvider {
//    static var previews: some View {
//        BackgroundWidgetView()
//    }
//}
