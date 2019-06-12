//
//  ViewController.swift
//  ARDicee
//
//  Created by Ociel Lerma on 6/5/19.
//  Copyright © 2019 Ociel Lerma. All rights reserved.
//

import UIKit
import SceneKit
import ARKit

class ViewController: UIViewController, ARSCNViewDelegate {

    //MARK: - Properites
    @IBOutlet var sceneView: ARSCNView! = {
       var scnView = ARSCNView()
        scnView.showsStatistics = true
        scnView.autoenablesDefaultLighting = true

        return scnView
    }()
    
    var diceArray = [SCNNode]()
    /***************************************************
     * ViewDidLoad
     ***************************************************/

    override func viewDidLoad() {
        super.viewDidLoad()
        sceneView.delegate = self
        createScene()
    }
    
    /***************************************************
     * CreateScene
     ***************************************************/
    func createScene(){
        // Create a new scene
        let diceScene = SCNScene(named: "art.scnassets/diceCollada.scn")!
        if let diceNode = diceScene.rootNode.childNode(withName: "Dice", recursively: true){
            diceNode.position = SCNVector3(0, 0, -0.1)
            // Set the scene to the view
            sceneView.scene.rootNode.addChildNode(diceNode)
        }
    }
    
    /***************************************************
     * ViewWillAppear
     ***************************************************/
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let configuration = ARWorldTrackingConfiguration()
        configuration.planeDetection = .horizontal
        sceneView.session.run(configuration)
    }
    
    /***************************************************
     * ViewWillDisappear
     ***************************************************/
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        sceneView.session.pause()
    }
    /***************************************************
     * Touches Began
     ***************************************************/
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            let touchLocation = touch.location(in: sceneView)
            let results = sceneView.hitTest(touchLocation, types: .existingPlaneUsingExtent)
    
            if let hitResult = results.first {
                addDice(at: hitResult)
            }else {
                print("Touched somewhere else")
            }
            
        }
    }

    func addDice(at location: ARHitTestResult){
        let diceScene = SCNScene(named: "art.scnassets/diceCollada.scn")!
        if let diceNode = diceScene.rootNode.childNode(withName: "Dice", recursively: true){
            diceNode.position = SCNVector3(location.worldTransform.columns.3.x,
                                           location.worldTransform.columns.3.y + diceNode.boundingSphere.radius,
                                           location.worldTransform.columns.3.z)
            
            diceArray.append(diceNode)
            sceneView.scene.rootNode.addChildNode(diceNode)
            roll(dice: diceNode)
            
            
        }
        
    }
    
    

    //MARK: - Rolling Functions
    func rollAll(){
        if !diceArray.isEmpty {
            for dice in diceArray {
                roll(dice: dice)
            }
        }
    }
    
    func roll(dice: SCNNode){
        let randomX = Float(arc4random_uniform(4) + 1) * (Float.pi/2)
        let randomZ = Float(arc4random_uniform(4) + 1) * (Float.pi/2)
        dice.runAction(.rotateBy(x: CGFloat(randomX * 5),
                                     y: 0,
                                     z: CGFloat(randomZ * 5),
                                     duration: 0.5))
    }
    
    @IBAction func rollAgain(_ sender: UIBarButtonItem) {
        rollAll()
    }
    
    @IBAction func removeAllDice(_ sender: UIBarButtonItem) {
        
        if !diceArray.isEmpty {
            for dice in diceArray {
                dice.removeFromParentNode()
            }
        }
    }
    override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        rollAll()
    }
    
    //MARK: - ARSCNViewDelegationMethods
    
    /***************************************************
     * Renderer
     ***************************************************/
    func renderer(_ renderer: SCNSceneRenderer, didAdd node: SCNNode, for anchor: ARAnchor) {

        guard let planeAnchor = anchor as? ARPlaneAnchor else {return}
        let planeNode = createPlane(with: planeAnchor)
        node.addChildNode(planeNode)

    }

    //MARK: - Plane Rendering Methods
    func createPlane(with planeAnchor: ARPlaneAnchor) -> SCNNode{
        let plane = SCNPlane(width: CGFloat(planeAnchor.extent.x), height: CGFloat(planeAnchor.extent.z))
        let planeNode = SCNNode()
        planeNode.position = SCNVector3(x: planeAnchor.center.x, y: 0, z: planeAnchor.center.z)
        planeNode.transform = SCNMatrix4MakeRotation(-Float.pi/2, 1, 0, 0)
        
        let gridMaterial = SCNMaterial()
        gridMaterial.diffuse.contents = UIImage(named: "art.scnassets/grid.png")
        plane.materials = [gridMaterial]
        planeNode.geometry = plane

        return planeNode
    }
}

//let planeAnchor = anchor as! ARPlaneAnchor
