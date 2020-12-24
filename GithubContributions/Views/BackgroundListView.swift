//
//  BackgroundListView.swift
//  GithubContributions
//
//  Created by Kirtan Patel on 12/23/20.
//

import SwiftUI

struct BackgroundListView: View {
    var body: some View {
        List {
            BackgroundItem()
            BackgroundItem()
            BackgroundItem()
            BackgroundItem()
            BackgroundItem()


        }.navigationTitle("Backgrounds")
    }
}

struct BackgroundItem: View {
    var body: some View {
        VStack(alignment: .leading) {
            Text("Flag")
                .foregroundColor(.gray)
            HStack {
                Spacer()
                ZStack {
                    RoundedRectangle(cornerRadius: 10)
                        .frame(width: 300, height: 120)
                        .foregroundColor(.green)
                    
                    RoundedRectangle(cornerRadius: 10)
                        .frame(width: 300, height: 120)
                        .foregroundColor(.pink)
                        .clipShape(Triangle())
                }
                Spacer()
            }
        }
        .padding(.bottom, 10)
    }
}

struct Triangle: Shape {
    func path(in rect: CGRect) -> Path {
            var path = Path()

            path.move(to: CGPoint(x: rect.minX, y: rect.minY))
            path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
            path.addLine(to: CGPoint(x: rect.maxX, y: rect.minY))
            path.addLine(to: CGPoint(x: rect.minX, y: rect.minY))

            return path
        }
}

struct BackgroundListView_Previews: PreviewProvider {
    static var previews: some View {
        BackgroundListView()
    }
}
