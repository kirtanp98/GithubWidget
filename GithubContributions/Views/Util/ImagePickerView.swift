//
//  ImagePickerView.swift
//  GithubContributions
//
//  Created by Kirtan Patel on 12/26/20.
//

import Foundation
import SwiftUI

struct ImagePickerView: UIViewControllerRepresentable {
    typealias UIViewControllerType = UIImagePickerController

    @Binding var isPresented: Bool
    @Binding var selectedImage: UIImage?
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(parent: self)
    }
        
    func makeUIViewController(context: UIViewControllerRepresentableContext<ImagePickerView>) -> UIImagePickerController {
        let controller = UIImagePickerController()
        controller.delegate = context.coordinator
        return controller
    }
    
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: UIViewControllerRepresentableContext<ImagePickerView>) {
    
    }
    
    class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
        
        let parent: ImagePickerView
        
        init(parent: ImagePickerView) {
            self.parent = parent
        }
        
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            if let selectedImageFromPicker = info[.originalImage] as? UIImage {
                print(selectedImageFromPicker)
                parent.selectedImage = resizeImage(image: selectedImageFromPicker)

            }
            else if let selectedImageFromPicker = info[.editedImage] as? UIImage {
                parent.selectedImage = resizeImage(image: selectedImageFromPicker)

            }
            
//            simpleSuccess()
            picker.dismiss(animated: true, completion: nil)
            parent.isPresented = false
        }
        
        func resizeImage(image: UIImage) -> UIImage {
            let width = image.size.width
            let height = image.size.height
            UIGraphicsBeginImageContext(CGSize(width: width, height: height))
            image.draw(in: CGRect(x: 0, y: 0, width: width, height: height))
            let newImage = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            return newImage!
        }
        
    }
    
}
