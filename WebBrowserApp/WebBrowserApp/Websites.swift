//
//  Websites.swift
//  WebBrowserApp
//
//  Created by Ociel Lerma on 3/30/19.
//  Copyright © 2019 Ociel Lerma. All rights reserved.
//

import Foundation

class Websites {
    var websites = [String]()
    
    init() {
        websites += ["apple.com", "hackingwithswift.com",
                     "google.com", "yahoo.com", "facebook.com",
                     "amazon.com", "youtube.com"]
    }
    
    func getWebsiteCount() -> Int {
        return websites.count
    }
    
    func getWebsiteArray() -> [String]{
        return websites
    }
    
}
