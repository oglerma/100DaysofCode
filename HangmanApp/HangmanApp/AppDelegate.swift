//
//  AppDelegate.swift
//  HangmanApp
//
//  Created by Lerma, Ociel(AWF) on 4/24/19.
//  Copyright © 2019 oglerma. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        setUpInitialRootVC()
        
        return true
    }
    
    // Set GameViewController as the initial RootViewController
    private func setUpInitialRootVC(){
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        
        let uiVC = GameViewController()
        let navControler = UINavigationController(rootViewController: uiVC)
        window?.rootViewController = navControler
    }

}

