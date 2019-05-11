//
//  Person.swift
//  RecognizingFaces -UICollectionVC
//
//  Created by Ociel Lerma on 5/4/19.
//  Copyright © 2019 Ociel Lerma. All rights reserved.
//

import UIKit

class Person: NSObject {
    var name: String
    var image: String
    
    init(name: String,image: String) {
        self.name = name
        self.image = image
    }

}
