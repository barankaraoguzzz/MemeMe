//
//  ViewController.swift
//  MemeMe
//
//  Created by BARAN BATUHAN KARAOGUZ on 18.02.2021.
//

import UIKit

class ViewController: UIViewController {

    ///IBOutlet veriables
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var labelTop: UITextField!
    @IBOutlet weak var labelBottom: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
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
    
}

