//
//  MainMenuScene.swift
//  Bunny Scroller
//
//  Created by Christopher De Jesus on 7/21/18.
//  Copyright © 2018 Christopher De Jesus. All rights reserved.
//

import SpriteKit

class MainMenuScene: SKScene {

    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches{
            
            let location = touch.location(in: self)
            
            if atPoint(location).name == "Start"{
                if let scene = GameplayScene(fileNamed: "GameplayScene") {
                    // Set the scale mode to scale to fit the window
                    scene.scaleMode = .aspectFill
                    
                    // Present the scene
                    view!.presentScene(scene, transition: SKTransition.doorsOpenVertical(withDuration: TimeInterval(1)))
                }
            }
        }
        
    }
}
