//
//  ViewController.swift
//  MemeMe
//
//  Created by BARAN BATUHAN KARAOGUZ on 18.02.2021.
//

import UIKit

class MemeViewController: UIViewController {

    ///Constants
    
    ///IBOutlet veriables
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var textFieldTop: MemeTextFields!
    @IBOutlet weak var textFieldBottom: MemeTextFields!
    @IBOutlet weak var buttonCamera: UIBarButtonItem!
    
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureButtons()
        self.configureTextFields()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    ///IBAction
    
    @IBAction func openCameraAct(_ sender: Any) {
        appContainer.imagePicker.showImagePicker(fromViewController: self, sourceType: .camera) { (image) in
            self.imageView.image = image
        }
    }
    
    @IBAction func openGaleryAct(_ sender: Any) {
        appContainer.imagePicker.showImagePicker(fromViewController: self, sourceType: .photoLibrary) { (image) in
            self.imageView.image = image
        }
    }
    
    @IBAction func cancelButtonAct(_ sender: Any) {
        
    }
    
    @IBAction func shareButtonAct(_ sender: Any) {
        
    }
    
    // MARK: - Private confiure methods
    
    private func configureButtons() {
        buttonCamera.isEnabled = appContainer.imagePicker.isAvailable(by: .camera)
    }
    
    private func configureTextFields() {
        self.textFieldTop.delegate = self
        self.textFieldBottom.delegate = self
    }
    
}



