//
//  GameplayScene.swift
//  Bunny Scroller
//
//  Created by Christopher De Jesus on 7/1/18.
//  Copyright © 2018 Christopher De Jesus. All rights reserved.
//

import SpriteKit


class GameplayScene: SKScene, SKPhysicsContactDelegate{
    
    private var bg1: BGClass?;
    private var bg2: BGClass?;
    private var bg3: BGClass?;

    
    private var ground1: GroundClass?;
    private var ground2: GroundClass?;
    private var ground3: GroundClass?;

    private var floor1: GroundClass?;
    private var floor2: GroundClass?;
    private var floor3: GroundClass?;

    
    private var player: Player?;
    
    
    private var mainCamera: SKCameraNode?;
    private var scoreLabel: SKLabelNode?
    private var score = 0
    
    private var itemController = ItemController()
    
    override func didMove(to view: SKView) {
        initializeGame();
    }
    
    override func update(_ currentTime: TimeInterval) {
        manageCamera();
        manageBGsAndGrounds();
        player?.move();
        moveRocket()
        
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        //reverseGravity();
        jumping();
        
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        var firstBody = SKPhysicsBody()
        var secondBody = SKPhysicsBody()
        
        if contact.bodyA.node?.name == "Player" {
            firstBody = contact.bodyA
            secondBody = contact.bodyB
        }
        else{
            firstBody = contact.bodyB
            secondBody = contact.bodyA
        }
        
        if firstBody.node?.name == "Player" && secondBody.node?.name == "carrot"{
            secondBody.node?.removeFromParent()
            score += 1
            scoreLabel?.text = String(score)
        }
        if firstBody.node?.name == "Player" && secondBody.node?.name == "blood"{
            firstBody.node?.removeFromParent()

            secondBody.node?.removeFromParent()

            Timer.scheduledTimer(timeInterval: TimeInterval(2), target: self, selector: #selector (GameplayScene.restartGame), userInfo: nil, repeats: false)
        }
        

    }
    
    private func initializeGame(){
        
        physicsWorld.contactDelegate = self
        
        
        
        
        mainCamera = childNode(withName: "MainCamera") as? SKCameraNode;
        
  //      bg1 = childNode(withName: "BG1") as? BGClass;
  //      bg2 = childNode(withName: "BG2") as? BGClass;
  //      bg3 = childNode(withName: "BG3") as? BGClass;

        ground1 = childNode(withName: "Ground1") as? GroundClass;
        ground2 = childNode(withName: "Ground2") as? GroundClass;
        ground3 = childNode(withName: "Ground3") as? GroundClass;
        
        ground1?.initializeFloorAndGround()
        ground2?.initializeFloorAndGround()
        ground3?.initializeFloorAndGround()
        
        floor1 = childNode(withName: "Floor1") as? GroundClass;
        floor2 = childNode(withName: "Floor2") as? GroundClass;
        floor3 = childNode(withName: "Floor3") as? GroundClass;

        floor1?.initializeFloorAndGround()
        floor2?.initializeFloorAndGround()
        floor3?.initializeFloorAndGround()


        
        player = childNode(withName: "Player") as? Player;
        player?.initializePlayer();
        
        
        
        
      
        
        
        scoreLabel = mainCamera!.childNode(withName: "ScoreLabel") as? SKLabelNode
        scoreLabel?.text = "0"
        
        Timer.scheduledTimer(timeInterval: TimeInterval(itemController.randomBetweenNumbers(firstNum: 1, secondNum: 3))
, target: self, selector: #selector (GameplayScene.spawnItems), userInfo: nil, repeats: true)
        
        Timer.scheduledTimer(timeInterval: TimeInterval(7), target: self, selector: #selector (GameplayScene.removeItems), userInfo: nil, repeats: true)
        
    }
    
    private func manageCamera(){
        self.mainCamera?.position.x += 20;
        
    }
    
    private func manageBGsAndGrounds(){
        bg1?.moveBG(camera: mainCamera!);
        bg2?.moveBG(camera: mainCamera!);
        bg3?.moveBG(camera: mainCamera!);

        ground1?.moveGroundsOrFloors(camera: mainCamera!);
        ground2?.moveGroundsOrFloors(camera: mainCamera!);
        ground3?.moveGroundsOrFloors(camera: mainCamera!);
        
        floor1?.moveGroundsOrFloors(camera: mainCamera!);
        floor2?.moveGroundsOrFloors(camera: mainCamera!);
        floor3?.moveGroundsOrFloors(camera: mainCamera!);



    }
    
  
    private func reverseGravity(){
        physicsWorld.gravity.dy *= -1
        player?.reversePlayer()
        
    }
    
    @objc private func spawnItems(){
        self.scene?.addChild(itemController.spawnItem(camera: mainCamera!))
        
    }
    
    private func jumping(){
        player?.upAndDown()
    }
    
    @objc private func restartGame() {
        if let scene = MainMenuScene(fileNamed: "MyScene") {
            // Set the scale mode to scale to fit the window
            scene.scaleMode = .aspectFill
            
            // Present the scene
            view!.presentScene(scene, transition: SKTransition.doorsOpenVertical(withDuration: TimeInterval(1)))
        }
        
    }
    
    private func moveRocket() {
        enumerateChildNodes(withName: "blood", using: ({
            (node, error) in
            if self.score % 5 == 0{
                node.position.x -= 5
            }
            else if self.score % 5 == 1{
                node.position.x -= 20
                
            }
            else if self.score % 5 == 2{
                node.position.x -= 15

            }
            else if self.score % 5 == 3{
                node.position.x -= 1

            }
            else if self.score % 5 == 4{
                node.position.x -= 28

            }


        }))
    }
    
    @objc func removeItems() {
        for child in children {
            if child.name == "carrot" || child.name == "blood"{
                if child.position.x < self.mainCamera!.position.x - self.scene!.frame.width / 2 {
                    child.removeFromParent()
                }
            }
        
        }
        
    }


}




