//
//  DogImage.swift
//  DogAPI_random
//
//  Created by Ociel Lerma on 6/15/19.
//  Copyright © 2019 Ociel Lerma. All rights reserved.
//

import Foundation

/***************************************************
 * CODABLE PROTOCOL (Contains both below)
 * Encodable : FROM SWIFT OBJECT TO JSON
 * Decodable : FROM JSON TO SWIFT OBJECT
 ***************************************************/


struct DogImage: Codable {
    let status: String
    let message: String
}
