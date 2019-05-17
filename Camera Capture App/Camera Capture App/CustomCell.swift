//
//  CustomCell.swift
//  Camera Capture App
//
//  Created by Lerma, Ociel(AWF) on 5/14/19.
//  Copyright © 2019 oglerma. All rights reserved.
//

import UIKit

class CustomCell: UITableViewCell{
    var cellView: UIView = {
        var cellV = UIView()
        cellV.layer.cornerRadius = 20
        cellV.backgroundColor = .white
        cellV.addShadow()
        return cellV
    }()
    
    var mainImage: UIImageView = {
        var img = UIImageView()
        img.contentMode = .scaleToFill
        img.layer.borderColor = UIColor.lightGray.cgColor
        img.layer.masksToBounds = true
        img.layer.cornerRadius = 55
        return img
    }()
    
    var imageLabel: UILabel = {
        var lbl = UILabel()
        return lbl
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUp()
    }
    
    func setUp(){
        backgroundColor = .white
        self.addSubview(cellView)
        cellView.addSubview(mainImage)
        cellView.addSubview(imageLabel)
        
        cellView.anchor(top: self.topAnchor,
                         leading:self.leadingAnchor,
                         bottom: self.bottomAnchor,
                         trailing: self.trailingAnchor,
                         centerXaxis: nil,
                         centerYaxis: nil,
                         padding: .init(top: 4, left: 8, bottom: 4, right: 8))

        mainImage.anchor(top: nil,
                         leading: cellView.leadingAnchor,
                         bottom: nil,
                         trailing: nil,
                         centerXaxis: nil,
                         centerYaxis: cellView.centerYAnchor,
                         padding: .init(top: 2, left: 12, bottom: 2, right: 0),
                         size: .init(width: 110, height: 120) )
        
        imageLabel.anchor(top: cellView.topAnchor,
                          leading: mainImage.trailingAnchor,
                          bottom: cellView.bottomAnchor,
                          trailing: trailingAnchor,
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
        self.layer.shadowRadius = 4.0
        self.layer.shadowOffset = CGSize(width: 1.0, height: 1.0)
    }
}
