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
    @IBOutlet weak var buttonShare: UIBarButtonItem!
    @IBOutlet weak var toolBar: UIToolbar!
    
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureButtons()
        self.configureTextFields()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.addObserver()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.removeObserver()
    }
    
    ///IBAction
    
    @IBAction func openCameraAct(_ sender: Any) {
        appContainer.imagePicker.showImagePicker(fromViewController: self, sourceType: .camera) { (image) in
            self.imageView.image = image
            self.buttonShare.isEnabled = true
        }
    }
    
    @IBAction func openGaleryAct(_ sender: Any) {
        appContainer.imagePicker.showImagePicker(fromViewController: self, sourceType: .photoLibrary) { (image) in
            self.imageView.image = image
            self.buttonShare.isEnabled = true
        }
    }
    
    @IBAction func cancelButtonAct(_ sender: Any) {
        self.imageView.image = nil
        self.textFieldTop.text = "TOP"
        self.textFieldBottom.text = "BOTTOM"
        self.buttonShare.isEnabled = false
    }
    
    @IBAction func shareButtonAct(_ sender: Any) {
        appContainer.shareManeger.startShareWith(from: self, withSharingTypeProtocol: .image(image: generateMemedImage()))
    }
    
    // MARK: - Private confiure methods
    
    private func configureButtons() {
        buttonCamera.isEnabled = appContainer.imagePicker.isAvailable(by: .camera)
        buttonShare.isEnabled = imageView.image != nil
    }
    
    private func configureTextFields() {
        self.textFieldTop.delegate = self
        self.textFieldBottom.delegate = self
    }
    
    /// Observers
    
    private func addObserver() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil);
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil);
    }
    
    private func removeObserver() {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    ///Helpers
    ///Actually i was use IBKeyboardManager. This pod is very simple and useable
    private func getKeyboardHeight(_ notification: Notification) -> CGFloat {
        let spaceBetweenTxtFieldAndKeyboard : CGFloat = 5.0
        
        if let userInfo = notification.userInfo,  let keyboardFrame = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            let keyboardFrameOriginY = keyboardFrame.cgRectValue.origin.y
            let keyBoardFrameHeight = keyboardFrame.cgRectValue.size.height
            if keyboardFrameOriginY >= UIScreen.main.bounds.size.height {
                return 0
            }
            else {
                if getTextFieldYPosition() > keyboardFrameOriginY {
                    let viewOriginY = (getTextFieldYPosition() - keyboardFrameOriginY) + spaceBetweenTxtFieldAndKeyboard
                    if viewOriginY > keyBoardFrameHeight {
                        return keyBoardFrameHeight
                    }
                    else {
                        return viewOriginY
                    }
                }
            }
        }
        return 0
    }
    
    private func getTextFieldYPosition() -> CGFloat {
        if let activeTextField = UIResponder.currentFirst() as? UITextField ?? UIResponder.currentFirst() as? UITextView {
            // Here we will get accurate frame of textField which is selected if there are multiple textfields
            let frame = self.view.convert(activeTextField.frame, from:activeTextField.superview)
            return frame.origin.y + frame.size.height
        }
        return 0
    }
    
    ///Memed Images
    func generateMemedImage() -> UIImage {

        self.toolBar.isHidden = true
        self.navigationController?.isNavigationBarHidden = true

        // Render view to an image
        UIGraphicsBeginImageContext(self.view.frame.size)
        view.drawHierarchy(in: self.view.frame, afterScreenUpdates: true)
        let memedImage:UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()

        
        self.toolBar.isHidden = false
        self.navigationController?.isNavigationBarHidden = false

        return memedImage
    }
}

//MARK: - TextFields Delegates

extension MemeViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.text = ""
    }
    
    @objc func keyboardWillShow(_ notification: Notification) {
         self.view.frame.origin.y -= getKeyboardHeight(notification)
    }

    @objc func keyboardWillHide(_ notification: Notification) {
         self.view.frame.origin.y = 0
    }
    
}
