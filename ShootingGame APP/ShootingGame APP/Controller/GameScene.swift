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
    
    var gameOverLbl: SKSpriteNode = {
        let gameOver = SKSpriteNode(imageNamed: "gameOver")
        gameOver.position = CGPoint(x: 512, y: 384)
        return gameOver
    }()
    
    var scoreLbl: SKLabelNode = {
        let score = SKLabelNode(fileNamed: "scoreLabel")
        score?.zPosition = 9
        score?.position = CGPoint(x: 512, y: 30)
        return score ?? SKLabelNode()
    }()
    
    var score = 0 {
        didSet{
            scoreLbl.text = "\(score)"
        }
    }
    // MARK: - TIME TICKERS
    var gameTicker: Timer?

    var targets = [SKSpriteNode]()
    // MARK: - GAME LOGIC BEGINS
    
    
    override func didMove(to view: SKView) {
        // SET sizes
        curtainImg.size = view.frame.size
        frontWater.size = CGSize(width: view.frame.width, height: frontWater.frame.height)
        backWater.size  = CGSize(width: view.frame.width, height: backWater.frame.height)
        grass.size      = CGSize(width: view.frame.width, height: grass.frame.height)
        
        addChildNodes(scoreLbl,curtainImg,frontWater,backWater,grass)
        startGame()
    }
    
    
    func startGame(){
        clearGame()
        moveWater()
        gameTicker = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(doSomething), userInfo: nil, repeats: true)
        
    }

    @objc func doSomething(){
        print("Inside of do somehting")
        let sprite = createRandomTarget()
        addChild(sprite)
        
        // Direction will be either right 1100 or left -1100
        let direction = sprite.position.x == 0 ? 1100 : -1100
        let move = SKAction.move(by: CGVector(dx: direction, dy: 0), duration: 3)
        sprite.run(move)
        
    }
    
    override func update(_ currentTime: TimeInterval) {
        //Check to see if the targets are off screen (delete if they are)
        for (index, node) in targets.enumerated().reversed(){
            if node.position.x > 1030 || node.position.x < 0 {
               deleteTarget(node: node,atIndex: index)
            }
        }
    }
    
    
    func clearGame(){
        gameTicker?.invalidate()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else {return}
        let location = touch.location(in: self)
        let allNodesAroundTheTouchedLocation = nodes(at: location)
        
        
        
        
        
        
    }
    
    func targetHit(){
        
    }
    
    func createRandomTarget() -> SKSpriteNode {
        let num = (Int.random(in: 0...9) % 3)
        let randomSprite = SKSpriteNode(imageNamed: "target\(num)")
        giveName(to: randomSprite, at: num)
        let ramndomPosition = [0, 1024].randomElement()!
        
        // Flip image if coming from left to right
        if ramndomPosition == 1024 {
            randomSprite.xScale = -1
        }
        
        let randomeRowToAppear = [Location.top.value,
                                  Location.middle.value,
                                  Location.bottom.value].randomElement()!
        randomSprite.position = CGPoint(x: ramndomPosition,
                                        y: randomeRowToAppear)
        assignZPosition(for: randomSprite, in: randomeRowToAppear)
        targets.append(randomSprite)
        return randomSprite
    }
    
    func assignZPosition(for node: SKSpriteNode, in row: Int){
        // Give a Z Position to the DUCK depending on what
        // Location they aredisplaying in the game.
        if row == Location.top.value {
            node.zPosition = Rows.zero.value
        } else if row == Location.middle.value {
            node.zPosition = Rows.two.value
        } else if row == Location.bottom.value {
            node.zPosition = Rows.four.value
        }
    }
    
    func giveName(to node: SKSpriteNode,at num: Int){
        switch num {
        case 0:
            node.name = "badTarget"
        case 1:
            node.name = "goodDuckOne"
        case 2:
            node.name = "goodDuckTwo"
        case 3:
            node.name = "goodDuckThree"
        default:
            node.name = ""
        }
    }
    
    func deleteTarget(node: SKSpriteNode,atIndex index: Int){
        targets.remove(at: index)
        node.removeFromParent()
    }
    // MARK: - Handling game logic
    /***************************************************
     * moveWater gives the effect of the water images moving back and forth.
     ***************************************************/
    func moveWater(){
        let moveRight = SKAction.move(by: CGVector(dx: 45, dy: 7), duration: 0.5)
        let moveLeft = SKAction.move(by: CGVector(dx: -45, dy: -7), duration: 0.5)
        
        let sequence = SKAction.sequence([moveRight, moveLeft])
        let sequence2 = SKAction.sequence([moveLeft, moveRight])
        
        let repeatForever = SKAction.repeatForever(sequence)
        let repeatForever2 = SKAction.repeatForever(sequence2)
        
        frontWater.run(repeatForever)
        backWater.run(repeatForever2)
    }

    
}








// MARK: - HELPER functions
extension GameScene {
    func addChildNodes(_ nodes:SKNode...){
        for node in nodes{
            addChild(node)
        }
    }
    
}

// THINGS TO DO :
// CREATE a function that return a randome duck target image or just a target image.
// create something that sets the duck on the screen in it respective place.
// add movement to the random images.
// delete them from the game when tapped.
// create animation for when a duck or target is hit.
// Keep score of how many ducks were shots and how many targets were hit.
// Keep a times that counts down until the game is over.
// Load sounds every time a user fires, loads, or hos no more ammunations.
// add button that reloads you entire arsenal.




