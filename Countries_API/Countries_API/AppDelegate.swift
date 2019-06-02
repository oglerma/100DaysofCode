//
//  AppDelegate.swift
//  Countries_API
//
//  Created by Ociel Lerma on 6/1/19.
//  Copyright © 2019 Ociel Lerma. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        setUp()
        return true
    }


    func setUp(){
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        let uiVC = CountriesViewController()
        let navController = UINavigationController(rootViewController: uiVC)
        window?.rootViewController = navController
    }

}

