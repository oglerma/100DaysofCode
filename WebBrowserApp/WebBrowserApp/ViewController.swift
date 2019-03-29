//
//  ViewController.swift
//  WebBrowserApp
//
//  Created by Ociel Lerma on 3/26/19.
//  Copyright © 2019 Ociel Lerma. All rights reserved.
//

import UIKit
import WebKit

/***************************************************
 *
 ***************************************************/

class ViewController: UIViewController, WKNavigationDelegate {
    
    var webView: WKWebView!
    var openImage: UIImage?
    var progressView: UIProgressView!
    
    
    override func loadView(){
        webView = WKWebView()
        webView.navigationDelegate = self
        view = webView
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        makeTheToolBar()
        
        /***************************************************
         * with add observr you are observing the progress view
         * which you will also have to put a remove observer.
         * You have to do that so that you know when you are done
         * observing the value.
         ***************************************************/
        webView.addObserver(self, forKeyPath: #keyPath(WKWebView.estimatedProgress), options: .new, context: nil)
        
        let url = URL(string: "https://www.hackingwithswift.com")!
        webView.load(URLRequest(url: url))
        webView.allowsBackForwardNavigationGestures = true
        
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Open", style: .plain, target: self, action: #selector(openTapped))
        
        
    }
    
    func makeTheToolBar(){
        let progress = makeCustomProgressViewButtonForToolBar()
        let spacer = UIBarButtonItem(barButtonSystemItem: .flexibleSpace,
                                     target: self, action: nil)
        let refresh = UIBarButtonItem(barButtonSystemItem: .refresh,
                                      target: nil, action: #selector(webView.reload))
        
        toolbarItems = [progress, spacer, refresh]
        navigationController?.isToolbarHidden = false
    }
    
    func makeCustomProgressViewButtonForToolBar() -> UIBarButtonItem{
        progressView = UIProgressView(progressViewStyle: .default)
        // Makes the progress view automatically take the size it needs
        progressView.sizeToFit()
        let progress = UIBarButtonItem(customView: progressView)
        return progress
    }
    
    @objc
    func loadProgressView(){
        
    }
    
    func loadImage()-> UIImage?{
        let image = UIImage(named: "chekcmark.png")
        return image
    }
    
    @objc
    func openTapped(){
        
        let vc = UIAlertController(title: "Open page...", message: nil, preferredStyle: .actionSheet)
        vc.addAction(UIAlertAction(title: "apple.com", style: .default, handler: openPage))
        vc.addAction(UIAlertAction(title: "hackingwithswift.com", style: .default, handler: openPage))
        vc.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        vc.popoverPresentationController?.barButtonItem = self.navigationItem.rightBarButtonItem
        present(vc,animated: true)
        
        
    }
    
    func openPage(action: UIAlertAction) {
        let url = URL(string: "https://" + action.title!)!
        webView.load(URLRequest(url: url))
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        title = webView.title
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "estimatedProgress"{
            progressView.progress = Float(webView.estimatedProgress)
        }
    }
    
}

