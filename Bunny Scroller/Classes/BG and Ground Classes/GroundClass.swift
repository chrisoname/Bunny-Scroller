//
//  Ground Class.swift
//  Bunny Scroller
//
//  Created by Christopher De Jesus on 7/1/18.
//  Copyright © 2018 Christopher De Jesus. All rights reserved.
//

import SpriteKit


class GroundClass: SKSpriteNode{
    
    func initializeFloorAndGround(){
        physicsBody = SKPhysicsBody(rectangleOf: self.size)
        physicsBody?.affectedByGravity = false
        physicsBody?.isDynamic = false
        physicsBody?.categoryBitMask = ColliderType.GROUND
        physicsBody?.restitution = 0
        
    }
    
    func moveGroundsOrFloors(camera: SKCameraNode){
        if self.position.x + self.size.width < camera.position.x {
            self.position.x += self.size.width * 3;
        }
    }
    
}
