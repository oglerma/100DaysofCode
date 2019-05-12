//
//  CollectionViewController.swift
//  Project1
//
//  Created by Ociel Lerma on 5/4/19.
//  Copyright © 2019 Ociel Lerma. All rights reserved.
//

import UIKit

class CollectionViewController: UICollectionViewController {

    var pictures = [String]()
    
    // By default Dictionaries are Codable
    var viewCounter = [String: Int]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Storm Viewer"
        collectionView.backgroundColor = #colorLiteral(red: 0.8114321828, green: 0, blue: 0, alpha: 0.6398223459)
        navigationController?.navigationBar.prefersLargeTitles = true
        performSelector(inBackground: #selector(fetchImages), with: nil)
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action , target: self, action: #selector(shareApp))
        loadSavedItems()


    }

    func loadSavedItems(){

        
        let defaults = UserDefaults.standard
        if let savedData = defaults.object(forKey: "viewCounter") as? Data {
            let jsonDecoder = JSONDecoder()
            do {
                viewCounter = try jsonDecoder.decode([String: Int].self, from: savedData)
            } catch {
                print("failed to decode")
            }
        }
    }

    // Fetch images in background thread
    @objc func fetchImages() {
        let fm = FileManager.default
        let path = Bundle.main.resourcePath!
        let items = try! fm.contentsOfDirectory(atPath: path).sorted()
        
        for item in items {
            if item.hasPrefix("nssl"){
                pictures.append(item)
            }
        }
        // Reload tableview on the main thread and not in the background thread.
        collectionView.performSelector(onMainThread: #selector(UITableView.reloadData), with: nil, waitUntilDone: false)
    }
    
    @objc func shareApp() {
        let shareText = "Share my app to the world"
        let vc = UIActivityViewController(activityItems: [shareText], applicationActivities: [])
        vc.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
        present(vc, animated: true)
    }
    

    // MARK: UICollectionViewDataSource
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return pictures.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath)
                         as? PictureCollectionViewCell else { fatalError("Can't get pictures")}
        cell.imageView.image = UIImage(named: pictures[indexPath.item])
        cell.imageView.layer.cornerRadius = 4
        cell.picNumber.text = "Picture \(indexPath.row + 1)"
        cell.viewCount.text = "Views: \(viewCounter[pictures[indexPath.item]] ?? 0)"
        
        cell.backgroundColor = #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1)
        cell.layer.cornerRadius = 8
        return cell
    }

    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "Detail") as? DetailViewController {
            vc.selectedImage = pictures[indexPath.row]
            vc.imageNumber = indexPath.row + 1
            vc.totalImages = pictures.count
            
            //Check to see if the we have added onto our dictionary a key with the value of the Name of the picture
            // If that key exists we will increment the count
            // else we will add the key for the first time into our Dictionary.
            // After it is added, it should never see this else statment again.
            if viewCounter.keys.contains(pictures[indexPath.item]){
                // You have to unwrap it since the value inside the value inside ViewCounter is optional
                // since we know it exists, because we checked with the contains, we can force unwrap it.
                viewCounter[pictures[indexPath.item]]! += 1
            }else {
                viewCounter[pictures[indexPath.item]] = 1
            }
            save()
            navigationController?.pushViewController(vc, animated: true)
            collectionView.reloadData()
            
        }
    }
    
    func save(){

        let jsonEndcoder = JSONEncoder()
        if let savedData = try? jsonEndcoder.encode(viewCounter){
            let defaults = UserDefaults.standard
            defaults.set(savedData, forKey: "viewCounter")
        }else {
            print("Can't save the views from viewCounter property")
        }
    }


}
