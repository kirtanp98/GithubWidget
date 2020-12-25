//
//  BaseView.swift
//  GithubContributions
//
//  Created by Kirtan Patel on 12/24/20.
//

import SwiftUI

struct BaseView: View {
    @Environment(\.colorScheme) var colorScheme
    @EnvironmentObject var modalController: ModalController

    var body: some View {
        ZStack {
            ContentView()
            
            if modalController.modal {
                VisualEffectView(uiVisualEffect: UIBlurEffect(style: colorScheme == .dark ? .dark : .light))
                    .edgesIgnoringSafeArea(.all)
                    .onTapGesture {
                        withAnimation {
                            modalController.dismissModal()
                        }
                    }
                    .transition(.opacity)
                    .zIndex(2)
                    .ignoresSafeArea(.keyboard, edges: .bottom)
            }
            
            if modalController.modal {
                Color.clear.overlay(
                    AddColorPaletteView()
                )
                .zIndex(3)
                .ignoresSafeArea(.keyboard, edges: .bottom)
            }
            
        }
    }
}

struct BaseView_Previews: PreviewProvider {
    static var previews: some View {
        BaseView()
    }
}
