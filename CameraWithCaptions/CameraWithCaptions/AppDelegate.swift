//
//  AppDelegate.swift
//  CameraWithCaptions
//
//  Created by Ociel Lerma on 5/13/19.
//  Copyright © 2019 Ociel Lerma. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
//        setUpInitialRootController()
        
        return true
    }

    func setUpInitialRootController(){
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        
        let vc = CameraTableViewController()
        let navController = UINavigationController(rootViewController: vc)
        window?.rootViewController = navController
        
    }
}

