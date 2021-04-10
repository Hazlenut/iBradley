//
//  GameScene.swift
//  FoodPet2
//
//  Created by William Wung on 4/10/21.
//  Copyright © 2021 William Wung. All rights reserved.
//
import SpriteKit
import GameplayKit

class GameScene: SKScene, UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    
    var viewController: UIViewController!
    private var label : SKLabelNode?
    private var spinnyNode : SKShapeNode?
    private var background = SKSpriteNode(imageNamed: "possiblebackground")
    private var button: SKNode! = nil
    var maskingCameraRolleChoice:Bool = false
    //var maskOffset:CGPoint = CGPointZero
    
    override func didMove(to view: SKView) {
        //background.position = CGPoint(x: frame.size.width / 2, y: frame.size.height / 2)
        background.size = CGSize(width: frame.size.width, height: frame.size.height)
        background.zPosition = 0
        // Get label node from scene and store it for use later
        /*
        self.label = self.childNode(withName: "//helloLabel") as? SKLabelNode
        if let label = self.label {
            label.alpha = 0.0
            label.run(SKAction.fadeIn(withDuration: 2.0))
        }
        */
        addChild(background)
        createButton()
        // Create shape node to use during mouse interaction
        /*
        let w = (self.size.width + self.size.height) * 0.05
        self.spinnyNode = SKShapeNode.init(rectOf: CGSize.init(width: w, height: w), cornerRadius: w * 0.3)
        
        if let spinnyNode = self.spinnyNode {
            spinnyNode.lineWidth = 2.5
            
            spinnyNode.run(SKAction.repeatForever(SKAction.rotate(byAngle: CGFloat(Double.pi), duration: 1)))
            spinnyNode.run(SKAction.sequence([SKAction.wait(forDuration: 0.5),
                                              SKAction.fadeOut(withDuration: 0.5),
                                              SKAction.removeFromParent()]))
        }
 */
    }
    
    func getPhotoFromSource(source: UIImagePickerController.SourceType) {
        if UIImagePickerController.isSourceTypeAvailable(source) {
            let image = UIImagePickerController()
            image.modalPresentationStyle = .currentContext
            image.delegate = self
            image.sourceType = source
            image.allowsEditing = false
            if(source == .camera) {
                image.cameraDevice = .front
            }
            
        }
    }
    
    func createButton() {
        button = SKSpriteNode(color: .yellow, size: CGSize(width: 100, height: 50))
        button.position = CGPoint(x: self.frame.midX , y: self.frame.midY)
        button.zPosition = 1
        self.addChild(button)
    }
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
      /*
        let touch = touches.first
        let touchLocation = touch!.location(in: self)
        if button.contains(touchLocation) {
            getPhotoFromSource(source: UIImagePickerController.SourceType.camera)
        }
 */
    }
    
    func touchDown(atPoint pos : CGPoint) {
        if let n = self.spinnyNode?.copy() as! SKShapeNode? {
            n.position = pos
            n.strokeColor = SKColor.green
            self.addChild(n)
        }
    }
    
    func touchMoved(toPoint pos : CGPoint) {
        if let n = self.spinnyNode?.copy() as! SKShapeNode? {
            n.position = pos
            n.strokeColor = SKColor.blue
            self.addChild(n)
        }
    }
    
    func touchUp(atPoint pos : CGPoint) {
        if let n = self.spinnyNode?.copy() as! SKShapeNode? {
            n.position = pos
            n.strokeColor = SKColor.red
            self.addChild(n)
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let label = self.label {
            label.run(SKAction.init(named: "Pulse")!, withKey: "fadeInOut")
        }
        
        for t in touches {
            self.touchDown(atPoint: t.location(in: self))
            let touch = touches.first
            let touchLocation = touch!.location(in: self)
            if button.contains(touchLocation) {
                getPhoto()
            }
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchMoved(toPoint: t.location(in: self)) }
    }
    /*
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
    }
 */
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
    }
    
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
}
