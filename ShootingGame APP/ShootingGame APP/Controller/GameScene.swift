//
//  GameScene.swift
//  ShootingGame APP
//
//  Created by Lerma, Ociel(AWF) on 6/19/19.
//  Copyright © 2019 oglerma. All rights reserved.
//

import SpriteKit

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    // MARK: - Background Images
    var curtainImg: SKSpriteNode = {
        let curtain = SKSpriteNode(imageNamed: "curtains")
        curtain.position = CGPoint(x: 512, y: 384)
        curtain.zPosition = Rows.five.value
        return curtain
    }()
    
    var frontWater: SKSpriteNode = {
        let fwater = SKSpriteNode(imageNamed: "water-fg")
        fwater.zPosition = Rows.four.value
        fwater.position = CGPoint(x: 512, y: 190)
        return fwater
    }()
    
    var backWater: SKSpriteNode = {
        let bwater = SKSpriteNode(imageNamed: "water-bg")
        bwater.position = CGPoint(x: 512, y: 200)
        bwater.zPosition = Rows.two.value
        return bwater
    }()
    
    var grass: SKSpriteNode = {
        let gr = SKSpriteNode(imageNamed: "grass-trees")
        gr.position = CGPoint(x: 512, y: 384)
        gr.zPosition = Rows.one.value
        return gr
    }()
    
    // MARK: - Duck Targets
    var topDuck: SKSpriteNode = {
        let duck = SKSpriteNode(imageNamed: "target1")
        duck.position = CGPoint(x: 300, y: 450)
        duck.zPosition = Rows.zero.value
        return duck
    }()
    
    var middleDuck: SKSpriteNode = {
        let duck = SKSpriteNode(imageNamed: "target3")
        duck.position = CGPoint(x: 0, y: Location.middle.value)
        duck.zPosition = Rows.two.value
        return duck
    }()
    
    var bottomDuck: SKSpriteNode = {
        let duck = SKSpriteNode(imageNamed: "target2")
        duck.position = CGPoint(x: 0, y: Location.bottom.value)
        duck.zPosition = Rows.four.value
        return duck
    }()
    

    // MARK: - GAME LOGIC BEGINS
    
    override func didMove(to view: SKView) {
        // SET sizes
        curtainImg.size = view.frame.size
        frontWater.size = CGSize(width: view.frame.width, height: frontWater.frame.height)
        backWater.size  = CGSize(width: view.frame.width, height: backWater.frame.height)
        grass.size      = CGSize(width: view.frame.width, height: grass.frame.height)
        
        addChild(curtainImg)
        addChild(bottomDuck)
        addChild(middleDuck)
        addChild(frontWater)
        addChild(backWater)
        addChild(grass)
        addChild(topDuck)

        
        moveDucks()
        moveWater()
        
        
        
    }
    
    // MARK: - Handling game logic
    /***************************************************
     * moveWater gives the effect of the water images moving back and forth.
     ***************************************************/
    func moveWater(){
        let moveRight = SKAction.move(by: CGVector(dx: 25, dy: 7), duration: 0.5)
        let moveLeft = SKAction.move(by: CGVector(dx: -25, dy: -7), duration: 0.5)
        
        let sequence = SKAction.sequence([moveRight, moveLeft])
        let sequence2 = SKAction.sequence([moveLeft, moveRight])
        
        let repeatForever = SKAction.repeatForever(sequence)
        let repeatForever2 = SKAction.repeatForever(sequence2)
        
        frontWater.run(repeatForever)
        backWater.run(repeatForever2)
    }
    
    
    
    /***************************************************
     * Moves duck left and right
     ***************************************************/
    func moveDucks(){
        let moveRight = SKAction.move(by: CGVector(dx: Move.right.value,
                                                   dy: Move.up.value), duration: 3)
        
        let moveLeft = SKAction.move(by: CGVector(dx: Move.left.value,
                                                  dy: Move.down.value), duration: 3)
        
        let sequence = SKAction.sequence([moveRight,moveLeft])
        let repeatForever = SKAction.repeatForever(sequence)
        middleDuck.run(repeatForever)
        
    }
    
    override func update(_ currentTime: TimeInterval) {
        let middleDuckXPosition = Int(middleDuck.position.x)
        
        
        if middleDuckXPosition > 1000 || middleDuckXPosition < 20 {
            middleDuck.xScale = middleDuck.xScale * -1
            print("First")
            print(middleDuck.xScale)
            print(middleDuck.position.x)
        }
    }
    


}




