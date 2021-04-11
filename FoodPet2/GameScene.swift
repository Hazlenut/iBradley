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
    
    var gifTextures: [SKTexture] = []
    var food:String = "empty.jpg"
   
    var character = SKSpriteNode(imageNamed: "1")
    
    var health = UserDefaults().integer(forKey: "HEALTH")
    var happiness = UserDefaults().integer(forKey: "HAPPINESS")
    var healthLabel = SKLabelNode()
    var happinessLabel = SKLabelNode()
    
    /*
    let character = SKSpriteNode(texture: SKTexture(image: UIImage.gifImageWithName("colorcharacter1")!))
    */
    
    
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
        for i in 1...3 {
            gifTextures.append(SKTexture(imageNamed: "\(i).jpg"))
        }
        character.zPosition = 2
        character.position = CGPoint(x: frame.midX, y: -500)
        character.size = CGSize(width: 120, height: 120)
        character.isPaused = false
        addChild(character)
        //character.run(SKAction.repeatForever(SKAction.animate(with: gifTextures, timePerFrame: 0.125)))
        healthLabel.zPosition = 2
        healthLabel.position = CGPoint(x: -100, y: 500)
        healthLabel.fontSize = 40
        healthLabel.fontColor = .black
        healthLabel.text = "HEALTH " + String(UserDefaults.standard.integer(forKey: "HEALTH"))
        addChild(healthLabel)
        
        happinessLabel.zPosition = 2
        happinessLabel.position = CGPoint(x: -100, y: 450)
        happinessLabel.fontSize = 40
        happinessLabel.fontColor = .black
        happinessLabel.text = "HAPPINESS " + String(UserDefaults.standard.integer(forKey: "HAPPINESS"))
        addChild(happinessLabel)
        //character.zPosition = 1
       // character.position = CGPoint(x: frame.midX, y: frame.size.height - 20)
        //addChild(character)
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
    func froggoEat() {
        character.run(SKAction.repeat(SKAction.animate(with: gifTextures, timePerFrame: 0.125), count: 8))
        
    }
    /*
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
    */
    func createButton() {
        button = SKSpriteNode(color: .yellow, size: CGSize(width: 100, height: 50))
        button.position = CGPoint(x: self.frame.midX , y: self.frame.midY)
        button.zPosition = 1
        self.addChild(button)
    }
    func updateHealthHappiness(health: Int, happiness: Int) {
        let newHealth = UserDefaults().integer(forKey: "HEALTH") + health
        let newHappiness = UserDefaults().integer(forKey: "HAPPINESS") + happiness
        UserDefaults.standard.set(newHealth, forKey: "HEALTH")
        UserDefaults.standard.set(newHappiness, forKey: "HAPPINESS")
        healthLabel.text = "HEALTH " + String(UserDefaults.standard.integer(forKey: "HEALTH"))
        happinessLabel.text = "HAPPINESS " + String(UserDefaults.standard.integer(forKey: "HAPPINESS"))

        
    }
    func throwFood(foodName: String) {
        print(foodName)
        if(foodName == "Hamburger") {
            food = "Hamburger1"
            updateHealthHappiness(health: 5, happiness: 10)
        }else if(foodName == "Hot Dog") {
            food = "Hot Dog1"
            updateHealthHappiness(health: -5, happiness: 4)
        }else if(foodName == "French Fries") {
            food = "French Fries1"
            updateHealthHappiness(health: -13, happiness: 17)
        }else if(foodName == "Pizza") {
            food = "Pizza1"
            updateHealthHappiness(health: -14, happiness: 25)
        }else if(foodName == "Rice") {
            food = "Rice1"
            updateHealthHappiness(health: -1, happiness: 1)
        }else if(foodName == "Noodles") {
            food = "Noodles1"
            updateHealthHappiness(health: 0, happiness: 15)
        }else if(foodName == "Orange") {
            food = "Oranges1.jpg"
            updateHealthHappiness(health: 15, happiness: -5)
        }else if(foodName == "Apple") {
            food = "Apple1"
            updateHealthHappiness(health: 15, happiness: -5)
        }else if(foodName == "Banana") {
            food = "Banana1"
            updateHealthHappiness(health: 15, happiness: -5)
        }else if(foodName == "Steak") {
            food = "Steak1"
            updateHealthHappiness(health: 10, happiness: 10)
        }else if(foodName == "Roach") {
            food = "Roach1"
            updateHealthHappiness(health: 100, happiness: 100)
        }else{
            //prompt input add in future
        }
        let foodTemp = SKSpriteNode(imageNamed: food)
        foodTemp.zPosition = 4
        foodTemp.position = CGPoint(x: frame.midX, y: -500)
        foodTemp.size = CGSize(width: 250, height: 250)
        self.addChild(foodTemp)
        foodTemp.run(SKAction.resize(toWidth: 0, height: 0, duration: 2))
        froggoEat()
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
                getPhoto(source: UIImagePickerController.SourceType.camera)
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
