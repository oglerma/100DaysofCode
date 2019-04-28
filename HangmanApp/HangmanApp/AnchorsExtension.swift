//
//  AnchorsExtension.swift
//  HangmanApp
//
//  Created by Ociel Lerma on 4/27/19.
//  Copyright © 2019 oglerma. All rights reserved.
//

import UIKit

extension UIView {
    func anchor(top: NSLayoutYAxisAnchor?, leading: NSLayoutXAxisAnchor?,
                bottom: NSLayoutYAxisAnchor?, trailing: NSLayoutXAxisAnchor?,
                centerXaxis: NSLayoutXAxisAnchor?, centerYaxis: NSLayoutYAxisAnchor?,
                padding: UIEdgeInsets = .zero, size: CGSize = .zero) {
        
        // NEEDED to activate autolayout constraints
        self.translatesAutoresizingMaskIntoConstraints = false
        
        // TOP, BOTTOM, LEFT AND RIGHT CONSTRAINTS
        if let top = top {
            self.topAnchor.constraint(equalTo: top,
                                 constant: padding.top).isActive = true
        }
        
        if let bottom = bottom {
            self.bottomAnchor.constraint(equalTo: bottom,
                              constant: padding.bottom).isActive = true

        }
        if let trailing = trailing {
            self.trailingAnchor.constraint(equalTo: trailing,
                                constant: -padding.right).isActive = true
        }
        if let leading = leading {
            self.leadingAnchor.constraint(equalTo: leading,
                               constant: padding.left).isActive = true
        }
        
        // CENTER X AXIS AND CENTER Y AXIS
        if let centerX = centerXaxis {
            self.centerXAnchor.constraint(equalTo: centerX).isActive = true
        }
        
        if let centerY = centerYaxis {
            self.centerYAnchor.constraint(equalTo: centerY).isActive = true
        }
        
        // Set the WIDTH AND HEIGHT WHEN SPECIFIED
        if size.width != 0 {
            self.widthAnchor.constraint(equalToConstant: size.width).isActive = true
        }
        
        if size.height != 0 {
            self.heightAnchor.constraint(equalToConstant: size.height).isActive = true
        }
    }
}
