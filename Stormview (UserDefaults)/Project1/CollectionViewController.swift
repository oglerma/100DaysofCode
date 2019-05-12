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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Storm Viewer"
        collectionView.backgroundColor = #colorLiteral(red: 0.8114321828, green: 0, blue: 0, alpha: 0.6398223459)
        navigationController?.navigationBar.prefersLargeTitles = true
        performSelector(inBackground: #selector(fetchImages), with: nil)
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action , target: self, action: #selector(shareApp))

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
        cell.backgroundColor = #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1)
        cell.layer.cornerRadius = 8
        return cell
    }

    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "Detail") as? DetailViewController {
            vc.selectedImage = pictures[indexPath.row]
            vc.imageNumber = indexPath.row + 1
            vc.totalImages = pictures.count
            navigationController?.pushViewController(vc, animated: true)
        }
    }


}
