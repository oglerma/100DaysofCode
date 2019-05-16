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
        cellV.backgroundColor = UIColor(red: 0, green: 0, blue: 170, alpha: 0.8)
        cellV.addShadow()
        return cellV
    }()

    var mainImage: UIImageView = {
        var img = UIImageView()
        img.contentMode = .scaleAspectFit
        img.backgroundColor = UIColor(red: 0, green: 255, blue: 170, alpha: 0.8)
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

        mainImage.anchor(top: cellView.topAnchor,
                         leading: cellView.leadingAnchor,
                         bottom: cellView.bottomAnchor,
                         trailing: nil,
                         centerXaxis: nil,
                         centerYaxis: nil,
                         padding: .init(top: 10, left: 8, bottom: 10, right: 0))
        
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
        self.layer.shadowRadius = 2.0
        self.layer.shadowOffset = CGSize(width: 1.0, height: 1.0)
    }
}
