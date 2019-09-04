//
//  MainTabBarController.swift
//  InstagramClone
//
//  Created by Ociel Lerma on 9/1/19.
//  Copyright © 2019 Ociel Lerma. All rights reserved.
//

import UIKit

class MainTabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

        let layout = UICollectionViewFlowLayout()
        let userProfileViewController = UserProfileController(collectionViewLayout: layout)
        
        let navController = UINavigationController(rootViewController: userProfileViewController)
        navController.tabBarItem.image = UIImage(named: "profile_unselected")
        navController.tabBarItem.selectedImage = UIImage(named: "profile_selected")
        tabBar.tintColor = .black
        
        viewControllers = [navController, UIViewController()]
        
        
        
    }
    
}
