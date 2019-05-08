//
//  GameScene.swift
//  Pachinko_app
//
//  Created by Lerma, Ociel(AWF) on 5/5/19.
//  Copyright © 2019 oglerma. All rights reserved.
//

import SpriteKit


class GameScene: SKScene, SKPhysicsContactDelegate {
    
    
    /***************************************************
     * SCORELABEL, SCORE, EDITLABEL, EDITING MODE, BACKGROUND
     ***************************************************/

    
    var scoreLabel: SKLabelNode! = {
        var sl = SKLabelNode(fontNamed: "Chalkduster")
        sl.text = "Score: 0"
        sl.horizontalAlignmentMode = .right
        sl.position = CGPoint(x: 980, y: 700)
        return sl
    }()
    
    var score = 0 {
        didSet{
            scoreLabel.text = "Score: \(score)"
        }
    }
    
    var editLabel: SKLabelNode! = {
        var el = SKLabelNode(fontNamed: "Chalkduster")
        el.text = "Edit"
        el.horizontalAlignmentMode = .right
        el.position = CGPoint(x: 80, y: 700)
        return el
    }()
    
    var editingMode: Bool = false {
        didSet{
            if editingMode {
                editLabel.text = "Done"
            } else {
                editLabel.text = "Edit"
            }
        }
    }
    
    
    let background: SKSpriteNode = {
       let b = SKSpriteNode(imageNamed: "background")
        b.position = CGPoint(x: 512, y: 384)
        b.blendMode = .replace
        b.zPosition = -1
        return b
    }()
    
    
    /***************************************************
     * MARK: BUILT IN FUNCTIONS TO THIS VIEW
     *      - DIDMOVE()
     *      - TOUCHESBEGAN()
     ***************************************************/
    override func didMove(to view: SKView) {

        addChild(background)
        addChild(scoreLabel)
        addChild(editLabel)
        
        physicsBody = SKPhysicsBody(edgeLoopFrom: frame)
        physicsWorld.contactDelegate = self
        
        makeSlot(at: CGPoint(x: 128, y: 0), isGood: true)
        makeSlot(at: CGPoint(x: 384, y: 0), isGood: false)
        makeSlot(at: CGPoint(x: 640, y: 0), isGood: true)
        makeSlot(at: CGPoint(x: 896, y: 0), isGood: false)
        
        makeBouncer(at: CGPoint(x: 0, y: 0))
        makeBouncer(at: CGPoint(x: 256, y: 0))
        makeBouncer(at: CGPoint(x: 512, y: 0))
        makeBouncer(at: CGPoint(x: 768, y: 0))
        makeBouncer(at: CGPoint(x: 1024, y: 0))
        

        
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else {return}
        let location = touch.location(in: self)
        let objects = nodes(at: location)
        
        // DID THEY TAP THE EDITING BUTTON
        if objects.contains(editLabel){
            editingMode.toggle()
        } else {
            if editingMode {
                // Create a box obstacle
                let size = CGSize(width: Int.random(in: 15...128), height: 16)
                let box = SKSpriteNode(color: UIColor(red: CGFloat.random(in: 0...1),
                                                      green: CGFloat.random(in: 0...1),
                                                      blue: CGFloat.random(in: 0...1),
                                                      alpha: 1), size: size)
                box.zRotation = CGFloat.random(in: 0...3)
                box.position = location
                box.physicsBody = SKPhysicsBody(rectangleOf: box.size)
                box.physicsBody?.isDynamic = false
                addChild(box)
            } else {
                let ball = SKSpriteNode(imageNamed: "ballRed")
                ball.physicsBody = SKPhysicsBody(circleOfRadius: ball.size.width / 2.0)
                ball.physicsBody?.restitution = 1
                ball.physicsBody?.contactTestBitMask = ball.physicsBody?.collisionBitMask ?? 0
                ball.position = location
                ball.name = "ball"
                addChild(ball)
            }

        }
        
        

    }
    
    
    
    func makeBouncer(at Position: CGPoint){
        let bouncer = SKSpriteNode(imageNamed: "bouncer")
        bouncer.position = Position
        bouncer.physicsBody = SKPhysicsBody(circleOfRadius: bouncer.size.width / 2)
        bouncer.physicsBody?.isDynamic = false
        addChild(bouncer)
    }
    
    func makeSlot(at position: CGPoint, isGood: Bool){
        let slotBase: SKSpriteNode
        let slotGlow: SKSpriteNode
        
        if isGood {
            slotBase = SKSpriteNode(imageNamed: "slotBaseGood")
            slotGlow = SKSpriteNode(imageNamed: "slotGlowGood")
            slotBase.name = "good"
        }else {
            slotBase = SKSpriteNode(imageNamed: "slotBaseBad")
            slotGlow = SKSpriteNode(imageNamed: "slotGlowBad")
            slotBase.name = "bad"
        }
        
        
        slotGlow.position = position
        slotBase.position = position
        slotBase.physicsBody = SKPhysicsBody(rectangleOf: slotBase.size)
        slotBase.physicsBody?.isDynamic = false
        
        addChild(slotBase)
        addChild(slotGlow)
        
        let spin = SKAction.rotate(byAngle: .pi, duration: 10)
        let spinForever = SKAction.repeatForever(spin)
        slotGlow.run(spinForever)
        
    }
    
    func collision(between ball: SKNode, object: SKNode){
        
        if object.name == "good"{
            destroy(ball: ball)
            score += 1
        }else if object.name == "bad"{
            destroy(ball: ball)
            score -= 1
        }
    }
    
    func destroy(ball: SKNode){
        
        if let fireParticles = SKEmitterNode(fileNamed: "FireParticles"){
            fireParticles.position = ball.position
            addChild(fireParticles)
        }
        ball.removeFromParent()
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        guard let NodeA = contact.bodyA.node else {return}
        guard let NodeB = contact.bodyB.node else {return}
        
        
        if NodeA.name == "ball"{
            collision(between: NodeA, object: NodeB)
        } else if NodeB.name == "ball"{
            collision(between: NodeB, object: NodeA)
        }
    }
    
    
    
    
}
