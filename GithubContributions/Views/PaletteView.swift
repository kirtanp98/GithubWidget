//
//  PaletteView.swift
//  GithubContributions
//
//  Created by Kirtan Patel on 12/23/20.
//

import SwiftUI

struct PaletteView: View {
    
    var palette: Palette
    
    var body: some View {
        VStack(alignment: .leading){
            Text(palette.wrappedName)
                .foregroundColor(.gray)
            PaletteRowView(palette: palette)
        }.padding(.bottom, 10)

    }
}

struct PaletteRowView: View {
    
    var palette: Palette
    
    var body: some View {
        HStack {
            
            ForEach(palette.colorArray, id: \.wrappedLevel) { pal in
                Spacer()
                Button(action: {
                    print(pal.wrappedLevel)
                }) {
                    VStack {
                        SplitCircle(colorOne: pal.wrappedLightColor, colorTwo: pal.wrappedDarkColor, size: 50)
                        Text("Level \(pal.wrappedLevel)")
                            .foregroundColor(.gray)
                            .font(.caption2)
                    }

                }.buttonStyle(PlainButtonStyle())
            }
            
            Spacer()
        }
    }
}

struct SplitCircle: View {
    var colorOne: Color
    var colorTwo: Color
    
    var size: CGFloat
    
    var body: some View {
        HStack(alignment: .center, spacing: 0){
            Rectangle()
                .foregroundColor(colorOne)
                .frame(width: size/2, height: size)
            Rectangle()
                .foregroundColor(colorTwo)
                .frame(width: size/2, height: size)
        }.clipShape(Circle())
    }
}

//struct PaletteView_Previews: PreviewProvider {
//    static var previews: some View {
//        PaletteView(palette: Palette()
//    }
//}
