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
        setNavigationUI()

    }
    
    func setNavigationUI(){
        navigationItem.title = "Add Contacts"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.barTintColor = UIColor(red: 0/255, green: 255/255, blue: 198/255, alpha: 1)
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 15)]
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .camera ,
                                                            target: self,
                                                            action: #selector(showImageOptionsActionSheet))
        navigationItem.rightBarButtonItem?.tintColor = UIColor.black
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
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCell.EditingStyle.delete {
            profile.remove(at: indexPath.row)
        }
        tableView.reloadData()
        save()
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140
    }


    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let profileCard = profile[indexPath.row]
        let path = getDocumentsDirectory().appendingPathComponent(profileCard.mainImage)
        
        let vc = DetailViewController()
        vc.detailImgView.image = UIImage(contentsOfFile: path.path)
        vc.detailTitleName = profileCard.imageLabel
        
        navigationController?.pushViewController(vc, animated: true)

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
        dismiss(animated: true)
        
        let ac = UIAlertController(title: "Add name", message: "Be creative!", preferredStyle: .alert)
        ac.addTextField()
        
        let nameAdded = UIAlertAction(title: "Add Name", style: .default){[weak self, weak ac] action in
            guard let usertextAnswer = ac?.textFields?[0].text else {return}
            let picWithAddTxt = ProfileCard(mainImage: imageName, imageLabel: usertextAnswer.uppercased() )
            self?.profile.append(picWithAddTxt)
            self?.save()
            self?.tableView.reloadData()
        }
        
        ac.addAction(nameAdded)
        present(ac,animated: true)

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




// TODO: add Detail VC
