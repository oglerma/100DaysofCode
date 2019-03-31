//
//  DetailViewController.swift
//  Project1
//
//  Created by Ociel Lerma on 3/10/19.
//  Copyright © 2019 Ociel Lerma. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet var imageView: UIImageView!
    
    var selectedImage: String?
    var imageNumber = 0
    var totalImages = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Picture \(imageNumber) of \(totalImages)"
        navigationItem.largeTitleDisplayMode = .never
        if let imageToLoad = selectedImage {
            imageView.image = UIImage(named: imageToLoad)
        }

    }
    
}
