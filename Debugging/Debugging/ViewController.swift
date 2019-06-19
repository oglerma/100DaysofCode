//
//  ViewController.swift
//  Debugging
//
//  Created by Lerma, Ociel(AWF) on 6/19/19.
//  Copyright © 2019 oglerma. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        // USING PRINT STATEMTNS
        print(1,2,3,4,5, separator: "-")
        // PRINTS (1-2-3-4-5)
        print("Another message", terminator: "\n")
        // PRINTS ANOTHER MESSAGE with a Line BREAK
        print("Some message", terminator: "")
        // DOES NOT PRINT WITH LINE BREAK
        
        
        assert(1 == 1, "Math failure!")
        
        for i in 1...100 {
            print("GOT NUMBER: \(i)")
        }
        
    }


}

