//
//  Capital.swift
//  CapitalCities_MapKit
//
//  Created by Ociel Lerma on 6/3/19.
//  Copyright © 2019 Ociel Lerma. All rights reserved.
//

import UIKit
import MapKit

class Capital: NSObject, MKAnnotation {
    var title: String?
    var coordinate: CLLocationCoordinate2D
    var info: String
    
    init(title: String, coordinate: CLLocationCoordinate2D, info: String) {
        self.title = title
        self.coordinate = coordinate
        self.info = info
    }

}
