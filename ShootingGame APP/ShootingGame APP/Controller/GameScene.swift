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
        
        addChildNodes(curtainImg,frontWater,backWater,grass)
        startGame()
    }
    
    
    func startGame(){
        clearGame()
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
    
    
    func createRandomTarget() -> SKSpriteNode {
        let num = (Int.random(in: 0...9) % 3)
        let randomSprite = SKSpriteNode(imageNamed: "target\(num)")
        let ramndomPosition = [0, 1024].randomElement()!
        
        let randomeRowToAppear = [Location.top.value,
                                  Location.middle.value,
                                  Location.bottom.value].randomElement()!
        
        // Give a Z Position to the DUCK depending on what Location they are
        // displaying in the game.
        if randomeRowToAppear == Location.top.value{
            randomSprite.zPosition = Rows.zero.value
        } else if randomeRowToAppear == Location.middle.value{
            randomSprite.zPosition = Rows.two.value
        } else if randomeRowToAppear == Location.bottom.value{
            randomSprite.zPosition = Rows.four.value
        }
        
        randomSprite.position = CGPoint(x: ramndomPosition,
                                        y: randomeRowToAppear)
        targets.append(randomSprite)
        return randomSprite
    }
    
    func assignTarget(){
        
    }
    
    func deleteTarget(node: SKSpriteNode,atIndex index: Int){
        targets.remove(at: index)
        node.removeFromParent()
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





//// MARK: - Handling game logic
///***************************************************
// * moveWater gives the effect of the water images moving back and forth.
// ***************************************************/
//func moveWater(){
//    let moveRight = SKAction.move(by: CGVector(dx: 25, dy: 7), duration: 0.5)
//    let moveLeft = SKAction.move(by: CGVector(dx: -25, dy: -7), duration: 0.5)
//
//    let sequence = SKAction.sequence([moveRight, moveLeft])
//    let sequence2 = SKAction.sequence([moveLeft, moveRight])
//
//    let repeatForever = SKAction.repeatForever(sequence)
//    let repeatForever2 = SKAction.repeatForever(sequence2)
//
//    frontWater.run(repeatForever)
//    backWater.run(repeatForever2)
//}
//
//
//
///***************************************************
// * Moves duck left and right
// ***************************************************/
//func moveDucks(){
//    let moveRight = SKAction.move(by: CGVector(dx: Move.right.value,
//                                               dy: Move.up.value), duration: 3)
//
//    let moveLeft = SKAction.move(by: CGVector(dx: Move.left.value,
//                                              dy: Move.down.value), duration: 3)
//
//    let sequence = SKAction.sequence([moveRight,moveLeft])
//    let repeatForever = SKAction.repeatForever(sequence)
//    middleDuck.run(repeatForever)
//
//}
//
//override func update(_ currentTime: TimeInterval) {
//    let middleDuckXPosition = Int(middleDuck.position.x)
//
//
//    if middleDuckXPosition > 1000 || middleDuckXPosition < 20 {
//        middleDuck.xScale = middleDuck.xScale * -1
//        print("First")
//        print(middleDuck.xScale)
//        print(middleDuck.position.x)
//    }
//}
//
//
//func createARandomTarget(){
//
//}
//

//// MARK: - Duck Targets
//var topDuck: SKSpriteNode = {
//    let duck = SKSpriteNode(imageNamed: "target1")
//    duck.position = CGPoint(x: 300, y: 450)
//    duck.zPosition = Rows.zero.value
//    return duck
//}()
//
//var middleDuck: SKSpriteNode = {
//    let duck = SKSpriteNode(imageNamed: "target3")
//    duck.position = CGPoint(x: 10, y: Location.middle.value)
//    duck.zPosition = Rows.two.value
//    return duck
//}()
//
//var bottomDuck: SKSpriteNode = {
//    let duck = SKSpriteNode(imageNamed: "target2")
//    duck.position = CGPoint(x: 10, y: Location.bottom.value)
//    duck.zPosition = Rows.four.value
//    return duck
//}()
//
