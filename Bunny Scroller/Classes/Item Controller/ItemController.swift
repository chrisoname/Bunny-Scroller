//
//  ItemController.swift
//  Bunny Scroller
//
//  Created by Christopher De Jesus on 7/15/18.
//  Copyright © 2018 Christopher De Jesus. All rights reserved.
//

import SpriteKit

class ItemController: SKSpriteNode {
    
  
    private var minY = CGFloat(-263), maxY = CGFloat(263)

     
  
    
    func spawnItem(camera: SKCameraNode) -> SKSpriteNode {
        
        var TextureAtlas = SKTextureAtlas()
        var TextureArray = [SKTexture]()
        
        
        TextureAtlas = SKTextureAtlas(named: "Image")
        var name: String
        for i in 1...TextureAtlas.textureNames.count{
            name = "blood\(i)"
            TextureArray.append(SKTexture(imageNamed: name))
        }
        
        let item: SKSpriteNode?
        var animateRocketAction = SKAction();

        if Int(randomBetweenNumbers(firstNum: 0, secondNum: 10)) >= 6 {

            
            
            item = SKSpriteNode(imageNamed: TextureAtlas.textureNames[0] as String)
            item?.name = "blood"
            item?.setScale(0.6)
          //  item?.physicsBody = SKPhysicsBody(rectangleOf: item!.size)
            item?.physicsBody?.usesPreciseCollisionDetection = true
            
            animateRocketAction = SKAction.animate(with: TextureArray, timePerFrame: 0.40, resize: false, restore: false )
            
            item?.run(SKAction.repeatForever(animateRocketAction))
            
            let path = CGMutablePath()
            path.addLines(between: [CGPoint(x: -5, y: 37), CGPoint(x: 5, y: 37), CGPoint(x: 10, y: 20),
                                    CGPoint(x: 56, y: -5), CGPoint(x: 37, y: -35), CGPoint(x: 15, y: -30),
                                    CGPoint(x: 12, y: -37), CGPoint(x: -12, y: -37), CGPoint(x: -15, y: -30),
                                    CGPoint(x: -37, y: -35), CGPoint(x: -56, y: -5), CGPoint(x: -10, y: 20),
                                    CGPoint(x: -5, y: 37)])
            path.closeSubpath()
            item?.physicsBody = SKPhysicsBody(polygonFrom: path)
            
            
        }
        else{
            item = SKSpriteNode(imageNamed: "carrot")
            item?.name = "carrot"
            item?.setScale(0.5)
            item?.physicsBody = SKPhysicsBody(circleOfRadius: item!.size.height / 2)
            item?.physicsBody?.usesPreciseCollisionDetection = true

        }
        
        
        
        
        item!.physicsBody?.affectedByGravity = false
        item?.physicsBody?.categoryBitMask = ColliderType.ROCKET_AND_COLLECTABLES
        
        item?.zPosition = 4
        item?.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        
        item?.position.x = camera.position.x + 900
        item?.position.y = randomBetweenNumbers(firstNum: minY, secondNum: maxY)
        
        return (item)!
    }
    
    func randomBetweenNumbers(firstNum: CGFloat, secondNum: CGFloat) -> CGFloat{
        
        return CGFloat(arc4random()) / CGFloat(UINT32_MAX) * abs(firstNum - secondNum) + min(firstNum, secondNum)
    }
}

