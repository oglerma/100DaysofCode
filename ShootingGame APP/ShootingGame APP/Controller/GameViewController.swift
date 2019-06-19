//
//  GameViewController.swift
//  ShootingGame APP
//
//  Created by Lerma, Ociel(AWF) on 6/19/19.
//  Copyright © 2019 oglerma. All rights reserved.
//

import UIKit
import SpriteKit


class GameViewController: UIViewController {

    let gameScene: SKScene? = {
        let gScene = SKScene(fileNamed: "GameScene")
        gScene?.scaleMode = .aspectFit
        return gScene
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let view = self.view as! SKView? {
            if let scene = gameScene {
                view.presentScene(scene)
            }
            view.ignoresSiblingOrder = true
            view.showsFPS = true
            view.showsNodeCount = true
        }
    }

    override var shouldAutorotate: Bool {
        return true
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .allButUpsideDown
        } else {
            return .all
        }
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }
}
