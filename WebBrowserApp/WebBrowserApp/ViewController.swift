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
    var progressView: UIProgressView!
    var detailWebesites = ""
    
    
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
        
        print(detailWebesites)
        print(detailWebesites)
        let url = URL(string: "https://www.\(detailWebesites)")!
        
        webView.load(URLRequest(url: url))
        webView.allowsBackForwardNavigationGestures = true
        
        
    }
    
    func makeTheToolBar(){
        let progress = makeCustomProgressViewButtonForToolBar()
        
        let goForward = UIBarButtonItem(title: "Forward",
                                        style: .plain,
                                        target: nil,
                                        action: #selector(webView.goForward))
        
        let goBackward = UIBarButtonItem(title: "Back",
                                         style: .plain,
                                         target: nil,
                                         action: #selector(webView.goBack))
        
        let spacer = UIBarButtonItem(barButtonSystemItem: .flexibleSpace,
                                     target: self,
                                     action: nil)
        let refresh = UIBarButtonItem(barButtonSystemItem: .refresh,
                                      target: nil,
                                      action: #selector(webView.reload))
        
        toolbarItems = [goBackward, spacer,
                        goForward,spacer,
                        progress, spacer,
                        refresh]
        
        navigationController?.isToolbarHidden = false
    }
    
    func makeCustomProgressViewButtonForToolBar() -> UIBarButtonItem{
        progressView = UIProgressView(progressViewStyle: .default)
        // Makes the progress view automatically take the size it needs
        progressView.sizeToFit()
        let progress = UIBarButtonItem(customView: progressView)
        return progress
    }
    
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        title = webView.title
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "estimatedProgress"{
            progressView.progress = Float(webView.estimatedProgress)
        }
        
    }
    
    /***************************************************
     * This method is either called in the beginning or at the end of loading
     * because of this we have the escaping keyword for the closure. This function
     * will check to see if the website is permissable. Meaning if it is one
     * of the websites we wanted to see then the progress view will be allowed
     * to load. Else it won't.
     ***************************************************/

    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        let url = navigationAction.request.url
        
        if let host = url?.host {
            for website in detailWebesites {
                if host.contains(website){
                    decisionHandler(.allow)
                    return
                }
            }
        }
        decisionHandler(.cancel)
        showWebsiteDeniedAlert()
    }
    
    
    func showWebsiteDeniedAlert(){
        let vc = UIAlertController(title: "Danger", message: "That URL is not allowed", preferredStyle: .alert)
        vc.addAction(UIAlertAction(title: "Okey Dokey", style: .cancel))
        present(vc, animated: true)
 
        
    }
    
    
}

