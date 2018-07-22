//
//  BGClass.swift
//  Bunny Scroller
//
//  Created by Christopher De Jesus on 7/1/18.
//  Copyright © 2018 Christopher De Jesus. All rights reserved.
//

import SpriteKit

class BGClass: SKSpriteNode{
    
    func moveBG(camera: SKCameraNode){
        if self.position.x + self.size.width < camera.position.x {
            self.position.x  += self.size.width * 3;
        }
    }
}
