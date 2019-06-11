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

    //MARK- Properites
    @IBOutlet var sceneView: ARSCNView! = {
       var scnView = ARSCNView()
        scnView.showsStatistics = true
        scnView.autoenablesDefaultLighting = true
        scnView.debugOptions = [ARSCNDebugOptions.showFeaturePoints]
        return scnView
    }()
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
     * Renderer
     ***************************************************/
    func renderer(_ renderer: SCNSceneRenderer, didAdd node: SCNNode, for anchor: ARAnchor) {
        if anchor is ARPlaneAnchor {
            let planeAnchor = anchor as! ARPlaneAnchor
            let plane = SCNPlane(width: CGFloat(planeAnchor.extent.x), height: CGFloat(planeAnchor.extent.z))
            let planeNode = SCNNode()
            planeNode.position = SCNVector3(x: planeAnchor.center.x, y: 0, z: planeAnchor.center.z)
            planeNode.transform = SCNMatrix4MakeRotation(-Float.pi/2, 1, 0, 0)
            
            let gridMaterial = SCNMaterial()
            gridMaterial.diffuse.contents = UIImage(named: "art.scnassets/grid.png")
            plane.materials = [gridMaterial]
            planeNode.geometry = plane
            node.addChildNode(planeNode)
        }else {
            return
        }
    }

}

////        let cube = SCNBox(width: 0.1, height: 0.1, length: 0.1, chamferRadius: 0.01)
//        let sphere = SCNSphere(radius: 0.2)
//        let material = SCNMaterial()
//        material.diffuse.contents = UIImage(named: "art.scnassets/moon.jpg")
//        sphere.materials = [material]
//
//        let node = SCNNode()
//        node.position = SCNVector3(0, 0.1, -0.5)
//        node.geometry = sphere
//
//        sceneView.scene.rootNode.addChildNode(node)
