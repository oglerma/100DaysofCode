//
//  DetailViewController.swift
//  Whitehouse Petition (Parsing JSON)
//
//  Created by Ociel Lerma on 4/12/19.
//  Copyright © 2019 Ociel Lerma. All rights reserved.
//

import UIKit
import WebKit

class DetailViewController: UIViewController {
    
    var webView: WKWebView!
    var detailItem: Petition?
    
    override func loadView() {
        webView = WKWebView()
        view = webView
    }
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let detailItem = detailItem else {return}
        let html = """
        <html>
        <head>
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <style>
        body{ font-size: 150%; }
        </style>
        </head>
        <body>
        <div style="background-color:lightblue">
        <h3>\(detailItem.title)</h3>
        </div>
        \(detailItem.body)
        <footer>
        <p>Number of signatures: \(detailItem.signatureCount)</p>
        <p>Data info:
        <a href="https://www.hackingwithswift.com/samples/petitions-1.json"> www.hackingwithswift.com </a>
        </p>
        </footer>
        </body>
        </html>
        """
        
        webView.loadHTMLString(html, baseURL: nil)
        
    }
    


}
