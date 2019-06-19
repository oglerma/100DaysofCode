//
//  GameScene.swift
//  Space Race
//
//  Created by Lerma, Ociel(AWF) on 6/18/19.
//  Copyright © 2019 oglerma. All rights reserved.
//

import SpriteKit


class GameScene: SKScene, SKPhysicsContactDelegate {
    // MARK: - Properties
    var starfield : SKEmitterNode!
    var player    : SKSpriteNode!
    var scoreLabel: SKLabelNode!
    
    var score = 0 {
        didSet {
            scoreLabel.text = "Score: \(score)"
        }
    }
    
    let possibleEnemies = ["ball", "hammer", "penguin"]
    var isGameOver = false
    var gameTimer: Timer?
    
    
    override func didMove(to view: SKView) {
        backgroundColor = .black
        starfield = SKEmitterNode(fileNamed: "starfield")!
        starfield.position = CGPoint(x: 1024, y: 384)
        starfield.advanceSimulationTime(10)
        addChild(starfield)
        starfield.zPosition = -1
        
        player = SKSpriteNode(imageNamed: "player")
        player.position = CGPoint(x: 100, y: 384)
        player.physicsBody = SKPhysicsBody(texture: player.texture!, size: player.size)
        player.physicsBody?.contactTestBitMask = 1
        addChild(player)
        
        
        scoreLabel = SKLabelNode(fontNamed: "Chalkduster")
        scoreLabel.position = CGPoint(x: 16, y: 16)
        scoreLabel.horizontalAlignmentMode = .left
        addChild(scoreLabel)
        
        score = 0
        
        physicsWorld.gravity = CGVector(dx: 0, dy: 0)
        physicsWorld.contactDelegate = self
        
        
        gameTimer = Timer.scheduledTimer(timeInterval: 0.35, target: self, selector: #selector(createEnemy), userInfo: nil, repeats: true)

    }
    
    @objc func createEnemy(){
        guard let enemy = possibleEnemies.randomElement() else {return}
        let sprite = SKSpriteNode(imageNamed: enemy)
        sprite.position = CGPoint(x: 1200, y: Int.random(in: 50...736))
        addChild(sprite)
        
        sprite.physicsBody = SKPhysicsBody(texture: sprite.texture!, size: sprite.size)
        sprite.physicsBody?.categoryBitMask = 1
        sprite.physicsBody?.velocity = CGVector(dx: -500, dy: 0)
        
        // ANGULAR VELOCITY IS A SPIN
        sprite.physicsBody?.angularVelocity = 5
        
        // LINEAR  DAMPING : Controls HOW FAST DO ITEMS SLOW DOWN OVER TIME: ZERO MEANS NEVER
        // ANGULAR DAMPING : Gives us some spine. And it will carry out spinning at a constant rate.
        sprite.physicsBody?.linearDamping = 0
        sprite.physicsBody?.angularDamping = 0
    }

    

    override func update(_ currentTime: TimeInterval) {
        for node in children {
            // IF the node is off screen by 300 we remove it from the game.
            if node.position.x < -300 {
                node.removeFromParent()
            }
        }
        if !isGameOver {
            score += 1
        }
    }
    

    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else {return}
        var location = touch.location(in: self)
        
        if location.y < 100 {
            location.y = 100
        }else if location.y > 668 {
            location.y = 668
        }
        
        player.position = location
    }
    
    
    // The funciton needed to check if our player made contact
    // with some node.
    func didBegin(_ contact: SKPhysicsContact) {
        let explosion = SKEmitterNode(fileNamed: "explosion")!
        explosion.position = player.position
        addChild(explosion)
        
        
        player.removeFromParent()
        isGameOver = true
    }
    
//    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
//        <#code#>
//    }
    
    
}


//TODO: - Give the player a name so that we can debug it.
//TODO: - Implement the touchesEnded method so that when the player lifts it's finger it doesn't transport to the other location.
// TODO: - Subtract the timer 0.1 seconds every time we create 20 enemies.
// TODO: - Learn how to use the invalidate function for game timer.
// TODO: - Stop creating Debri when the player has died. 
