//
//  ViewController.swift
//  RecognizingFaces -UICollectionVC
//
//  Created by Ociel Lerma on 5/4/19.
//  Copyright © 2019 Ociel Lerma. All rights reserved.
//

import UIKit

class ViewController: UICollectionViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 10
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Person", for: indexPath) as? PersonCell else {fatalError("Unable to deque a PersonCell")}
        
        return cell
    }
}

