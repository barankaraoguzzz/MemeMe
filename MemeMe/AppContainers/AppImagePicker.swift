//
//  AppImagePicker.swift
//  MemeMe
//
//  Created by BARAN BATUHAN KARAOGUZ on 18.02.2021.
//

import Foundation
import UIKit


class AppImagePicker: NSObject {
    
    /// Callbacks
    
    private var didSelectImageFromPhotoLibraryCallback: Callback<UIImage>?
    
    
    /// Public Methods
    
    public func showImagePicker(fromViewController: UIViewController, sourceType: UIImagePickerController.SourceType,  callback: @escaping Callback<UIImage>) {
        self.didSelectImageFromPhotoLibraryCallback = callback
        fromViewController.present(getImagePickerViewController(with: sourceType), animated: true, completion: nil)
    }

    
    /// Private methods
    
    private func getImagePickerViewController(with sourceType: UIImagePickerController.SourceType) -> UIImagePickerController {
        let pickerController = UIImagePickerController()
        pickerController.delegate = self
        pickerController.allowsEditing = true
        pickerController.sourceType = sourceType
        return pickerController
    }
    
}

// MARK: - UIImagePickerController Delegates

extension AppImagePicker: UIImagePickerControllerDelegate {

    public func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
        
    }

    public func imagePickerController(_ picker: UIImagePickerController,
                                      didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        if let image = info[.editedImage] as? UIImage {
            self.didSelectImageFromPhotoLibraryCallback?(image)
        }
        picker.dismiss(animated: true, completion: nil)
    }
}

// MARK: - UINavigationControllerDelegate Delegates

extension AppImagePicker: UINavigationControllerDelegate {}
