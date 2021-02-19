//
//  ViewController.swift
//  MemeMe
//
//  Created by BARAN BATUHAN KARAOGUZ on 18.02.2021.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


    @IBAction func rightButton(_ sender: Any) {
        appContainer.imagePicker.showImagePicker(fromViewController: self, sourceType: .camera) { (image) in
            print(image)
        }
    }
    @IBAction func leftButton(_ sender: Any) {
        appContainer.imagePicker.showImagePicker(fromViewController: self, sourceType: .photoLibrary) { (image) in
            print(image)
        }
    }
}

