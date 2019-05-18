//
//  DetailViewController.swift
//  Camera Capture App
//
//  Created by Lerma, Ociel(AWF) on 5/17/19.
//  Copyright © 2019 oglerma. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    var detailImgView: UIImageView = {
        var UIimgView = UIImageView()
        return UIimgView
    }()
    
    var detailTitleName:String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
        navigationItem.title = detailTitleName
        
    }
    
    func setUp(){
        view.addSubview(detailImgView)
        detailImgView.anchor(top: view.topAnchor,
                             leading: view.leadingAnchor,
                             bottom: view.bottomAnchor,
                             trailing: view.trailingAnchor,
                             centerXaxis: nil,
                             centerYaxis: nil)
    }
    
    
    // Not Entirely sure why but these two functions have to be added to this UIViewController
    // If you want it to work.
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
