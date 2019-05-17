//
//  CameraTableViewController.swift
//  Camera Capture App
//
//  Created by Lerma, Ociel(AWF) on 5/14/19.
//  Copyright © 2019 oglerma. All rights reserved.
//

import UIKit

let customCellID = "customIdentifier"
class CameraTableViewController: UITableViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {

    var profile = [ProfileCard]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadSavedData()
        tableView.register(CustomCell.self, forCellReuseIdentifier: customCellID)
        tableView.separatorStyle = .none
        tableView.allowsSelection = false
        navigationItem.title = "Add Contacts"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .camera , target: self, action: #selector(showImageOptionsActionSheet))

    }
    
    func loadSavedData(){
        let defaults = UserDefaults.standard
        if let savedData = defaults.object(forKey: "profile") as? Data {
            let jsonDecoder = JSONDecoder()
            do {
                let updatedProfile = try jsonDecoder.decode([ProfileCard].self, from: savedData)
                profile = updatedProfile
            }catch{
                print("couldn't decode the Profile")
            }
        }
    }

    @objc func showImageOptionsActionSheet(){
        let ac = UIAlertController(title: "Import Images", message: nil, preferredStyle: .actionSheet)
        ac.addAction(UIAlertAction(title: "Photo Library", style: .default){
            [weak self] action in
            self?.showImagePickerController(sourceType: .photoLibrary)
        })
        ac.addAction(UIAlertAction(title: "Take Photo", style: .default){
            [weak self] action in
            self?.showImagePickerController(sourceType: .camera)
        })
        ac.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        present(ac,animated: true)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return profile.count
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: customCellID, for: indexPath) as? CustomCell else {fatalError("Couldn't make it work")}
        let profileCard = profile[indexPath.row]
        let path = getDocumentsDirectory().appendingPathComponent(profileCard.mainImage)
        cell.mainImage.image = UIImage(contentsOfFile: path.path)
        cell.imageLabel.text = profileCard.imageLabel
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Add pictures"
    }
    
    func showImagePickerController(sourceType: UIImagePickerController.SourceType){
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        imagePickerController.allowsEditing = true
        imagePickerController.sourceType = sourceType
        present(imagePickerController, animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let imagePicked = info[.editedImage] as? UIImage else {return}
        let imageName = UUID().uuidString
        let imagePath = getDocumentsDirectory().appendingPathComponent(imageName)
        if let jpegData = imagePicked.jpegData(compressionQuality: 0.8){
            try? jpegData.write(to: imagePath)
        }
        
        let picWithAddTxt = ProfileCard(mainImage: imageName, imageLabel: "Add text")
        profile.append(picWithAddTxt)
        save()
        tableView.reloadData()
        dismiss(animated: true)
        
    }
    
    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
    
    func save(){
        let jsonEncoder = JSONEncoder()
        
        if let savedData = try? jsonEncoder.encode(profile) {
            let defaults = UserDefaults.standard
            defaults.set(savedData, forKey: "profile")
        }else{
            print("Failed to save Profile")
        }
        
    }
}



// TODO: Add saving to the app
// TODO: add Detail VC
// TODO: Remove items
// TODO: Add caption
// TODO: Show Saved images
// TODO: 
