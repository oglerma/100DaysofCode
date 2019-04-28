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
                padding: UIEdgeInsets = .zero, size: CGSize = .zero) {
        
        // NEEDED to activate autolayout constraints
        translatesAutoresizingMaskIntoConstraints = false
        
        // TOP, BOTTOM, LEFT AND RIGHT CONSTRAINTS
        if let top = top {
            topAnchor.constraint(equalTo: top,
                                 constant: padding.top).isActive = true
        }
        if let bottom = bottom {
            bottom.constraint(equalTo: bottom,
                              constant: padding.bottom).isActive = true
        }
        if let trailing = trailing {
            trailing.constraint(equalTo: trailing,
                                constant: padding.right).isActive = true
        }
        if let leading = leading {
            leading.constraint(equalTo: leading,
                               constant: padding.left).isActive = true
        }
        
        // Set the WIDTH AND HEIGHT WHEN SPECIFIED
        if size.width != 0 {
            widthAnchor.constraint(equalToConstant: size.width).isActive = true
        }
        
        if size.height != 0 {
            heightAnchor.constraint(equalToConstant: size.height).isActive = true
        }
    }
}
