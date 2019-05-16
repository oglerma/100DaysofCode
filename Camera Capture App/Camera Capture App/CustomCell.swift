//
//  CustomCell.swift
//  Camera Capture App
//
//  Created by Lerma, Ociel(AWF) on 5/14/19.
//  Copyright © 2019 oglerma. All rights reserved.
//

import UIKit

class CustomCell: UITableViewCell{
    

    var mainImage: UIImageView = {
        var img = UIImageView()
      
        img.translatesAutoresizingMaskIntoConstraints = false
        img.backgroundColor = .red
        return img
    }()
    
    var imageLabel: UILabel = {
        var lbl = UILabel()
        lbl.backgroundColor = .green
        return lbl
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUp()
    }
    
    func setUp(){

        addSubview(mainImage)
        addSubview(imageLabel)

        mainImage.anchor(top: self.topAnchor,
                         leading: self.leadingAnchor,
                         bottom: self.bottomAnchor,
                         trailing: nil,
                         centerXaxis: nil,
                         centerYaxis: nil,
                         padding: .init(top: 4, left: 8, bottom: 4, right: 8),
                         size: .init(width: 45, height: 0))
        
        imageLabel.anchor(top: self.topAnchor,
                          leading: mainImage.trailingAnchor,
                          bottom: self.bottomAnchor,
                          trailing: self.trailingAnchor,
                          centerXaxis: nil,
                          centerYaxis: nil,
                          padding: .init(top: 4, left: 8, bottom: 4, right: 8))
    
    }
    
    required init?(coder aDecoder: NSCoder) {
       fatalError("init(coder:) has not been implemented")
    }
    
    
    
}

extension UIView {
    func addShadow(){
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOpacity = 0.5
        self.layer.shadowRadius = 2.0
        self.layer.shadowOffset = CGSize(width: 1.0, height: 1.0)
    }
}
