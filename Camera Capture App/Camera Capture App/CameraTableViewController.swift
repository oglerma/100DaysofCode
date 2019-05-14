//
//  CameraTableViewController.swift
//  Camera Capture App
//
//  Created by Lerma, Ociel(AWF) on 5/14/19.
//  Copyright © 2019 oglerma. All rights reserved.
//

import UIKit

class CameraTableViewController: UITableViewController {

    @IBOutlet var imageView: UIImageView!
    @IBOutlet var imageLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .camera , target: self, action: #selector(showImageOptionsActionSheet))

    }

    @objc func showImageOptionsActionSheet(){
        
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)

        // Configure the cell...
        cell.textLabel?.text = "hello"

        return cell
    }
    
  

}

extension CameraTableViewController: UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    func showImagePickerController(sourceType: UIImagePickerController.SourceType){
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        imagePickerController.allowsEditing = true
        imagePickerController.sourceType = sourceType
        present(imagePickerController, animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[.editedImage] as? UIImage {
            imageView.image = image
        }
    }
    
    
}
