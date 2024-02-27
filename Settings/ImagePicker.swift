//
//  ImagePicker.swift
//  RaceGame
//
//  Created by Егор on 21.02.2024.
//

import UIKit

protocol iImagePicker {
    func showImagePicker(in viewcontroller: UIViewController, with completion: @escaping ((UIImage) -> (Void)))
}
final class ImagePicker: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate, iImagePicker {
    
    private var imagePickerController: UIImagePickerController?
    
    private var completion: ((UIImage) -> (Void))?
    
    func showImagePicker(in viewcontroller: UIViewController, with completion: @escaping (UIImage) -> (Void)) {
        self.completion = completion
        imagePickerController = UIImagePickerController()
        imagePickerController?.delegate = self
        viewcontroller.present(imagePickerController!, animated: true)
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let avatar = info[.originalImage] as? UIImage {
            self.completion?(avatar)
            picker.dismiss(animated: true)
        }
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true)
    }
    
}
