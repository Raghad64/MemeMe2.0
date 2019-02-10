//
//  MemeGeneratorVC.swift
//  MemeMe2.0
//
//  Created by Raghad Mah on 03/12/2018.
//  Copyright © 2018 Udacity. All rights reserved.
//

import Foundation
import UIKit

class MemeGeneratorVC: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate {
    @IBOutlet weak var bottomToolbar: UIToolbar!
    @IBOutlet weak var topToolbar: UIToolbar!
    
    @IBOutlet weak var imagePickerView: UIImageView!
    @IBOutlet weak var cameraOutlet: UIBarButtonItem!
    @IBOutlet weak var topTextField: UITextField!
    @IBOutlet weak var bottomTextField: UITextField!
    @IBOutlet weak var shareButtonOutlet: UIBarButtonItem!
    
    //MARK: CancelButton
    @IBAction func cancelButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    let imagePicker = UIImagePickerController()
    
    //MARK: Buttons functions
    @IBAction func camButton(_ sender: Any) {
        pickImage(from: .camera)
    }
    
    @IBAction func libraryButton(_ sender: Any) {
        pickImage(from: .photoLibrary)
    }
    //MARK: PickIMage function
    func pickImage(from source: UIImagePickerController.SourceType) {
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = source
        imagePicker.delegate = self
        imagePicker.allowsEditing = false
        present(imagePicker, animated: true, completion: nil)
    }
    
    @IBAction func shareButton(_ sender: Any) {
        let memeImage = generateMemedImage()
        let shareVC = UIActivityViewController(activityItems: [memeImage], applicationActivities: [])
        shareVC.completionWithItemsHandler = {(_,true,_,_) in
    
                self.save(image: memeImage)
                self.dismiss(animated: true, completion: nil)
        }
        present(shareVC, animated: true)
    }
    
    //MARK: ViewWillAppear & ViewWillDisappear Methods
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //Share button if-statement
        if imagePickerView.image == nil {
            shareButtonOutlet.isEnabled = false
        }
        else {
            shareButtonOutlet.isEnabled = true
        }
        //View adjustments related
        subscribeToKeyboardNotifications()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        //View adjustments related
        super.viewWillDisappear(animated)
        unsubscribeFromKeyboardNotifications()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imagePicker.delegate = self
        cameraOutlet.isEnabled = UIImagePickerController.isSourceTypeAvailable(.camera)
        customizeTextField(textField: topTextField, text: "TOP")
        customizeTextField(textField: bottomTextField, text: "BOTTOM")
    }
    
    // MARK: UIImagePickerController method
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let pickedImage = info[.originalImage] as? UIImage {
            imagePickerView.contentMode = .scaleAspectFit
            imagePickerView.image = pickedImage
        }
        else if let pickedImage = info[.editedImage] as? UIImage{
            imagePickerView.image = pickedImage
        }
        dismiss(animated: true, completion: nil)
    }
    
    //MARK: save method
    func save(image: UIImage){
        let meme = Meme(topText: topTextField.text!, bottomText: bottomTextField.text!, originalImage: imagePickerView.image!, memedImage: generateMemedImage())
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.memes.append(meme)
    }
    
    //MARK: generateMemedImage Method
    func generateMemedImage() -> UIImage{
        configureBars(true)
        //Generating Meme
        UIGraphicsBeginImageContext(self.view.frame.size)
        view.drawHierarchy(in: self.view.frame, afterScreenUpdates: true)
        let memedImage:UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        configureBars(false)
        return memedImage
    }
    //Hiding bars when the meme is generated
    func configureBars(_ isHidden: Bool) {
        bottomToolbar.isHidden = isHidden
        topToolbar.isHidden = isHidden
    }
    // MARK: View adjustments when keyboard appears
    func getKeyboardHeight(_ notification: Notification) -> CGFloat{
        let userInfo = notification.userInfo
        let keyboardSize = userInfo![UIResponder.keyboardFrameEndUserInfoKey] as! NSValue
        return keyboardSize.cgRectValue.height
    }
    //MARK: keyboardWillShow
    @objc func keyboardWillShow(_ notification: Notification){
        if bottomTextField.isFirstResponder{
            view.frame.origin.y = -getKeyboardHeight(notification)
            bottomToolbar.isHidden = true
        }
    }
    //MARK: keyboardWillHide
    @objc func keyboardWillHide(_ notification: Notification){
        view.frame.origin.y = 0
        bottomToolbar.isHidden = false
    }
    //MARK: Subscribe & Unsubscribe
    func subscribeToKeyboardNotifications(){
        NotificationCenter.default.addObserver(self, selector: #selector (keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector (keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    func unsubscribeFromKeyboardNotifications(){
        NotificationCenter.default.removeObserver(self)
    }
    
    //MARK: TextFields Settings
    func customizeTextField(textField: UITextField, text: String){
        let memeTextAttributes: [NSAttributedString.Key: Any] = [
            NSAttributedString.Key(rawValue: NSAttributedString.Key.strokeColor.rawValue): UIColor.black,
            NSAttributedString.Key(rawValue: NSAttributedString.Key.foregroundColor.rawValue): UIColor.white,
            NSAttributedString.Key(rawValue: NSAttributedString.Key.font.rawValue): UIFont(name: "HelveticaNeue-CondensedBlack", size: 30)!,
            NSAttributedString.Key(rawValue: NSAttributedString.Key.strokeWidth.rawValue): -2]
        textField.defaultTextAttributes = memeTextAttributes
        textField.textAlignment = .center
        textField.text = text
        textField.clearsOnBeginEditing = true
        textField.delegate = self
        
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        return textField.resignFirstResponder()
    }
}
