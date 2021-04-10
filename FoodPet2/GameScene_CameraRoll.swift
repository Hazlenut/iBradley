//
//  GameScene_CameraRoll.swift
//  FoodPet2
//
//  Created by William Wung on 4/10/21.
//  Copyright © 2021 William Wung. All rights reserved.
//

import Foundation
import SpriteKit

extension GameScene {
    
    func getPhoto() {
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.photoLibrary) {
            let image = UIImagePickerController()
            image.modalPresentationStyle = .currentContext
            image.delegate = self
            image.sourceType = UIImagePickerController.SourceType.photoLibrary
            image.allowsEditing = false
                 
            let vc:UIViewController = self.view!.window!.rootViewController!
            vc.present(image, animated: true, completion: nil)
             }
         }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if (picker.sourceType == UIImagePickerController.SourceType.photoLibrary || picker.sourceType == UIImagePickerController.SourceType.camera) {
            
        }
        picker.dismiss(animated: true, completion: nil)
        picker.delegate = nil
        
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
        picker.delegate = nil
    }
    
    
}
