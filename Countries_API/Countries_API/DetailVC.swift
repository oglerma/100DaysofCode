//
//  DetailVC.swift
//  Countries_API
//
//  Created by Ociel Lerma on 6/2/19.
//  Copyright © 2019 Ociel Lerma. All rights reserved.
//

import UIKit

class DetailVC: UIViewController {

    var flagImageView: UIImageView = {
        var imgV = UIImageView()
        return imgV
    }()

    var countryName: UILabel = {
        var lbl = UILabel()
        lbl.textAlignment = .center
        return lbl
    }()
    var countryCapital: UILabel = {
        var lbl = UILabel()
        lbl.textAlignment = .center
        return lbl
    }()
    var countryRegion: UILabel = {
        var lbl = UILabel()
        lbl.textAlignment = .center
        return lbl
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addViews()
        addAnchors()
    }
    
    private func addViews(){
        view.addSubview(flagImageView)
        view.addSubview(countryName)
        view.addSubview(countryCapital)
        view.addSubview(countryRegion)
    }
    
   private func addAnchors(){
        flagImageView.anchor(top: view.safeAreaLayoutGuide.topAnchor,
                             leading: view.safeAreaLayoutGuide.leadingAnchor,
                             bottom: nil,
                             trailing: view.safeAreaLayoutGuide.trailingAnchor,
                             centerXaxis: nil,
                             centerYaxis: nil,
                             padding: .init(top: 10, left: 40, bottom: 0, right: 40),
                             size: .init(width: 0, height: 180))
        countryName.anchor(top: flagImageView.bottomAnchor,
                             leading: view.safeAreaLayoutGuide.leadingAnchor,
                             bottom: nil,
                             trailing: view.safeAreaLayoutGuide.trailingAnchor,
                             centerXaxis: view.centerXAnchor,
                             centerYaxis: nil,
                             padding: .init(top: 10, left: 0, bottom: 0, right: 0))
        countryCapital.anchor(top: countryName.bottomAnchor,
                           leading: view.safeAreaLayoutGuide.leadingAnchor,
                           bottom: nil,
                           trailing: view.safeAreaLayoutGuide.trailingAnchor,
                           centerXaxis: nil,
                           centerYaxis: nil,
                           padding: .init(top: 10, left: 0, bottom: 0, right: 0))
        countryRegion.anchor(top: countryCapital.bottomAnchor,
                              leading: view.safeAreaLayoutGuide.leadingAnchor,
                              bottom: nil,
                              trailing: view.safeAreaLayoutGuide.trailingAnchor,
                              centerXaxis: nil,
                              centerYaxis: nil,
                              padding: .init(top: 10, left: 0, bottom: 0, right: 0))
    }


}
