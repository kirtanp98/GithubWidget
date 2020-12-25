//
//  ModalController.swift
//  GithubContributions
//
//  Created by Kirtan Patel on 12/24/20.
//

import Foundation

class ModalController: ObservableObject {
    @Published var modal = false
    
    public func toggleModal() {
        modal.toggle()
    }
    
    public func dismissModal() {
        modal = false
    }
    
    public func showModal() {
        modal = true
    }
}
