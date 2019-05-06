//
//  GameScene.swift
//  Pachinko_app
//
//  Created by Lerma, Ociel(AWF) on 5/5/19.
//  Copyright © 2019 oglerma. All rights reserved.
//

import SpriteKit


class GameScene: SKScene {
    override func didMove(to view: SKView) {
        let background = SKSpriteNode(imageNamed: "background")
        background.position = CGPoint(x: 512, y: 384)
        addChild(background)
    }

}
