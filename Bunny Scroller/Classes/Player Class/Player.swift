//
//  Player.swift
//  Bunny Scroller
//
//  Created by Christopher De Jesus on 7/2/18.
//  Copyright © 2018 Christopher De Jesus. All rights reserved.
//

import SpriteKit

struct ColliderType{
    static let PLAYER: UInt32 = 0;
    static let GROUND: UInt32 = 1;
    static let ROCKET_AND_COLLECTABLES: UInt32 = 2;

    
}


class Player : SKSpriteNode{
    
    var superBB = false
    private var playerAnimation = [SKTexture]();
    private var animatePlayerAction = SKAction();
    
    
    
    
    
    
    func initializePlayer(){
     //   name = "Player";
        
        if superBB == true{
            for i in 1...4{
                let name = "PlayerSuper \(i)"
                playerAnimation.append(SKTexture(imageNamed: name))
            }
        }
        else{
        
            for i in 1...4{
                let name = "Player \(i)"
                playerAnimation.append(SKTexture(imageNamed: name))
            }
        }
        animatePlayerAction = SKAction.animate(with: playerAnimation, timePerFrame: 0.20, resize: false, restore: false )
        self.run(SKAction.repeatForever(animatePlayerAction))


        let path = CGMutablePath()
        path.addLines(between: [CGPoint(x: -5, y: 37), CGPoint(x: 5, y: 37), CGPoint(x: 10, y: 20),
                                CGPoint(x: 56, y: -5), CGPoint(x: 37, y: -35), CGPoint(x: 15, y: -30),
                                CGPoint(x: 12, y: -37), CGPoint(x: -12, y: -37), CGPoint(x: -15, y: -30),
                                CGPoint(x: -37, y: -35), CGPoint(x: -56, y: -5), CGPoint(x: -10, y: 20),
                                CGPoint(x: -5, y: 37)])
        path.closeSubpath()
        physicsBody = SKPhysicsBody(polygonFrom: path)
        
        
        
        physicsBody?.affectedByGravity = true
        physicsBody?.allowsRotation = false
        physicsBody?.restitution = 0
        physicsBody?.categoryBitMask = ColliderType.PLAYER
        physicsBody?.collisionBitMask = ColliderType.GROUND
        physicsBody?.contactTestBitMask = ColliderType.ROCKET_AND_COLLECTABLES
        physicsBody?.usesPreciseCollisionDetection = true
        
        
        
    }

    func upAndDown(){
        // move up 20
        let jumpUpAction = SKAction.moveBy(x: 0, y:150, duration: 0.1)
        // move down 20
       // let jumpDownAction = SKAction.moveBy(x: 0, y:-200, duration: 1.0)
        

        // sequence of move yup then down
        let jumpSequence = SKAction.sequence([jumpUpAction])

        // make player run sequence
        self.run(jumpSequence)
        
        
    }
    
    func move(){
        self.position.x += 20
    }
    
    func reversePlayer(){
        self.yScale *= -1
    }
   
    
}

