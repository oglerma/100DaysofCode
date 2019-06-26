//
//  Constants.swift
//  ShootingGame APP
//
//  Created by Lerma, Ociel(AWF) on 6/25/19.
//  Copyright © 2019 oglerma. All rights reserved.
//

import UIKit
/***************************************************
 * Move.left.value will return the value amount by
 * which we want to move our nodes in the X and Y axis.
 ***************************************************/
enum Move {
    case left
    case right
    case up
    case down
    
    var value: Int {
        switch self {
        case .left:
            return -1024
        case .right:
            return 1024
        case .up:
            return 0
        case .down:
            return 0
        }
    }
}


/***************************************************
 * Rows.zero.value will be used to reference on what zPosition
 * is each node currently displaying on the screen. 
 ***************************************************/
enum Rows {
    case zero
    case one
    case two
    case three
    case four
    case five
    case six
    
    var value: CGFloat {
        switch self {
        case .zero:
            return 0
        case .one:
            return 1
        case .two:
            return 2
        case .three:
            return 3
        case .four:
            return 4
        case .five:
            return 5
        case .six:
            return 6
        }
}
}

/***************************************************
 * Location.top.value return the value associated with top DUCK.
 ***************************************************/

enum Location {
    case top
    case middle
    case bottom
    
    var value: Int {
        switch self {
        case .top:
            return 480
        case .middle:
            return 320
        case .bottom:
            return 140
        }
    }
}


