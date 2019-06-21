//
//  GameScene.swift
//  ShootingGame APP
//
//  Created by Lerma, Ociel(AWF) on 6/19/19.
//  Copyright © 2019 oglerma. All rights reserved.
//

import SpriteKit


class GameScene: SKScene, SKPhysicsContactDelegate {

    var curtainImg: SKSpriteNode = {
       let curtain = SKSpriteNode(imageNamed: "curtains")
        curtain.position = CGPoint(x: 512, y: 384)
        curtain.zPosition = -1
//        curtain.blendMode = .replace
        return curtain
    }()
    
    override func didMove(to view: SKView) {
        addChild(curtainImg)
    }
    

}
