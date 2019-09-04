//
//  UserProfileController.swift
//  InstagramClone
//
//  Created by Ociel Lerma on 9/3/19.
//  Copyright © 2019 Ociel Lerma. All rights reserved.
//

import UIKit
import Firebase
class UserProfileController: UICollectionViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.backgroundColor = .green
        navigationItem.title = "\(String(describing: Auth.auth().currentUser?.uid))"
        fetchUser()
        
    }
    
    fileprivate func fetchUser()  {
        guard let uid =  Auth.auth().currentUser?.uid else {return}
        Database.database().reference().child("users").child(uid).observeSingleEvent(of: .value, with: { (snapshot) in
            print(snapshot.value ?? "")
            guard let dictionary = snapshot.value as? [String: Any] else {return}
            let username = dictionary["username"] as? String
            self.navigationItem.title = username
        }) { (err) in
            print("Failed to fetch user: ", err)
        }
    }
}
