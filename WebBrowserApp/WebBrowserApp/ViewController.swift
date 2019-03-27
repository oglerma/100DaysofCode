//
//  ViewController.swift
//  WebBrowserApp
//
//  Created by Ociel Lerma on 3/26/19.
//  Copyright © 2019 Ociel Lerma. All rights reserved.
//

import UIKit
import WebKit

class ViewController: UIViewController, WKNavigationDelegate {
    
    var webView: WKWebView!
    var openImage: UIImage?
    
    override func loadView(){
        webView = WKWebView()
        webView.navigationDelegate = self
        view = webView
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let url = URL(string: "https://www.hackingwithswift.com")!
        webView.load(URLRequest(url: url))
        webView.allowsBackForwardNavigationGestures = true
        openImage = UIImage(named: "checkmark.png")
    
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Open", style: .plain, target: self, action: #selector(openTapped))
        
    }
    
    func loadImage()-> UIImage?{
        let image = UIImage(named: "chekcmark.png")
        
        return image
    }
    
    @objc
    func openTapped(){
//        let vc = UIAlertController(title: "Open page...", message: nil, preferredStyle: .actionSheet)
//        vc.addAction(UIAlertAction(title: "apple.com", style: .default, handler: openPage))
//        vc.addAction(UIAlertAction(title: "hackingwithswift.com", style: .default, handler: openPage))
    }
    
    func openPage(){
        
    }


}

