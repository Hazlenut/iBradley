//
//  GameScene_CameraRoll.swift
//  FoodPet2
//
//  Created by William Wung on 4/10/21.
//  Copyright © 2021 William Wung. All rights reserved.
//

import Foundation
import SpriteKit
import CoreML
import Vision

extension GameScene {
    
    func getPhoto(source: UIImagePickerController.SourceType) {
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.photoLibrary) {
            let image = UIImagePickerController()
            image.modalPresentationStyle = .currentContext
            image.delegate = self
            image.sourceType = source
            image.allowsEditing = false
                 
            let vc:UIViewController = self.view!.window!.rootViewController!
            vc.present(image, animated: true, completion: nil)
        }else if UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.camera) {
            let image = UIImagePickerController()
            image.modalPresentationStyle = .currentContext
            image.delegate = self
            image.sourceType = source
            image.allowsEditing = false
            if (source == .camera) {
                image.cameraDevice = .rear
            }
        }else{
            print("error message 1")
        }
         }
    func fixOrientation(picture: UIImage) -> UIImage {
        if(picture.imageOrientation == .up) {
            return picture
        }
            UIGraphicsBeginImageContextWithOptions(picture.size, false, picture.scale)
            let rect = CGRect(x: 0, y: 0, width: picture.size.width, height: picture.size.height)
            picture.draw(in: rect)
            let normalized = UIGraphicsGetImageFromCurrentImageContext()!
            UIGraphicsEndImageContext()
            return normalized
        
        
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if (picker.sourceType == UIImagePickerController.SourceType.photoLibrary || picker.sourceType == UIImagePickerController.SourceType.camera) {
            if var picture = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
                //UserDefaults.standard.setOjbect(UIImagePNGRepresentation(picture), forKey:"picture")
               // if(!maskingCameraRolleChoice) {
                    picture = fixOrientation(picture: picture)
                    let text:SKTexture = SKTexture(image: picture)
                    let newImage:SKSpriteNode = SKSpriteNode(texture: text)
                    newImage.name = "picture"
                newImage.size = CGSize(width: frame.size.width, height: frame.size.height)
                guard let ciImage = CIImage(image: picture) else {
                    fatalError("cannot convert to CIImage")
                }
    
                detect(image: ciImage)
                    self.addChild(newImage)
              //  }
            }
           /*
            if let picture = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
                guard let ciImage = CIImage(image: picture) else {
                    
                }
            }
            
                let model = try VNCoreMLModel(for: FoodImageClassifier1_1().model)
                let request = VNCoreMLRequest(model: model)
                let handler = VNImageRequestHandler(cgImage: image)
                
                */
        }
        picker.dismiss(animated: true, completion: nil)
        picker.delegate = nil
        
    }
    func detect(image: CIImage) {
        guard let model = try? VNCoreMLModel(for: FoodImageClassifier1_1().model) else {
            fatalError("coreml error")
        }
        let request = VNCoreMLRequest(model: model) { [self] (request, error) in
            guard let results = request.results as? [VNClassificationObservation] else {
                fatalError("processing image error")
            }
            self.throwFood(foodName: results.first!.identifier)
        }
        let handler = VNImageRequestHandler(ciImage: image)
        do {
            try handler.perform([request])
        }catch {
            print(error)
        }
        
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
        picker.delegate = nil
    }
    
    
}
