//
//  BreedsListResponse.swift
//  DogAPI_random
//
//  Created by Ociel Lerma on 6/15/19.
//  Copyright © 2019 Ociel Lerma. All rights reserved.
//

import Foundation

struct BreedsListResponse: Codable {
    let status: String
    let message: [String : [String]]
}
