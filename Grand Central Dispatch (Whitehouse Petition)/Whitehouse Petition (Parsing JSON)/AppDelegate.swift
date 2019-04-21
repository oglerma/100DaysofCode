//
//  AppDelegate.swift
//  Whitehouse Petition (Parsing JSON)
//
//  Created by Ociel Lerma on 4/11/19.
//  Copyright © 2019 Ociel Lerma. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Adding a new tabBarItem to our current RootViewControlles (Steps)
        
        // Check to see if there is a rootViewController with a subclass of UITabBarController
        if let tabBarViewController = window?.rootViewController as? UITabBarController{
            
            // IF there is one, find it using the name given to it. (i.e. Main.storyboard)
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            // Crete a new ViewController with the Storyboard ID (identifier) you gave it in the storyboard
            let vc = storyboard.instantiateViewController(withIdentifier: "NavController")
            // Create a UItabBarItem (Remember that there is already one set by you in the storyboard)
            vc.tabBarItem = UITabBarItem(tabBarSystemItem: .topRated, tag: 1)
            // Add it to your tabBarController (it will sync well with the one you currently have)
            tabBarViewController.viewControllers?.append(vc)
        }
        return true
    }

    // Deleted functions below func application(). This app doesnt require them at this time.
}

