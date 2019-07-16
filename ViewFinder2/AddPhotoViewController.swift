//
//  AddPhotoViewController.swift
//  ViewFinder2
//
//  Created by Eric Smith on 5/25/19.
//  Copyright © 2019 Eric Smith. All rights reserved.
//

import UIKit

class AddPhotoViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    
    var imagePicker = UIImagePickerController ()
    
    @IBOutlet weak var photoToSave: UIImageView!
    @IBOutlet weak var captionInput: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imagePicker.delegate = self
    }
    
    
    @IBAction func albumsTapped(_ sender: Any) {
        imagePicker.sourceType = .savedPhotosAlbum
        present(imagePicker, animated: true, completion: nil)
    }
    
    
    @IBAction func cameraTapped(_ sender: Any) {
        imagePicker.sourceType = .camera
        present(imagePicker, animated: true, completion: nil)
    }
    
    
//    @IBAction func savePhotoTapped(_ sender: UIButton) {
//
//        if let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext {
//            //we are in our core data database
//
//            let newCDPhoto = Photos(entity: Photos.entity(), insertInto: context)
//            //whatever text they typed it, it will become the caption of the photo we just saved.
//            newCDPhoto.caption = captionInput.text
//
//            if let userImage = photoToSave.image {
//                if let userImageData = userImage.pngData() {
//                    newCDPhoto.imageData = userImageData
//                }
//            }
//        }
//            (UIApplication.shared.delegate as? AppDelegate)?.saveContext()
//    navigationController?.popViewController(animated: true)
//

    @IBAction func savePhotoTapped(_ sender: UIButton) {
        if let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext {
                        //we are in our core data database
            
                    let newCDPhoto = Photos(entity: Photos.entity(), insertInto: context)
                        //whatever text they typed it, it will become the caption of the photo we just saved.
                    newCDPhoto.caption = captionInput.text
            
                    if let userImage = photoToSave.image {
                        if let userImageData = userImage.pngData() {
                                newCDPhoto.imageData = userImageData
                            }
                        }
                    }
                        (UIApplication.shared.delegate as? AppDelegate)?.saveContext()
                navigationController?.popViewController(animated: true)
        
    }
    
    
     func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let selectedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
        photoToSave.image = selectedImage
            
        }
        
    imagePicker.dismiss(animated: true, completion: nil)
        
    }
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
