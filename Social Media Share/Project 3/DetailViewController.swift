//
//  DetailViewController.swift
//  Project3
//
//  Created by Lerma, Ociel(AWF) on 3/23/19.
//  Copyright © 2019 Lerma, Ociel(AWF). All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    var loadedPicture: UIImage?
    var nameOfTheCountry = ""
    
    @IBOutlet var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        showImage()
        shareFlag()
    }
    
    private func showImage(){
        if let img = loadedPicture{
            imageView.image = img
            imageView.layer.borderWidth = 1
            imageView.layer.cornerRadius = 2
            imageView.layer.borderColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        }
    }
    
    //Show a Share action button in order to share the
    // country and flag you just pressed.
    private func shareFlag(){
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(flagShared))
    }
    
    @objc func flagShared(){
        let displayText = "Please share this image or \(nameOfTheCountry) with your mom!"
        let vc = UIActivityViewController(activityItems: [displayText, imageView.image!], applicationActivities: [])
        vc.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
        present(vc, animated: true)
    }
    
}
  
