//
//  ViewController.swift
//  Swifty Words Game
//
//  Created by Ociel Lerma on 4/13/19.
//  Copyright © 2019 Ociel Lerma. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var cluesLabel: UILabel = {
        var cluesLbl = UILabel()
        cluesLbl.translatesAutoresizingMaskIntoConstraints = false
        cluesLbl.font = UIFont.systemFont(ofSize: 24)
        cluesLbl.text = "CLUES"
        cluesLbl.backgroundColor = #colorLiteral(red: 0.60072124, green: 1, blue: 0.3980069458, alpha: 1)
        cluesLbl.numberOfLines = 0
        return cluesLbl
    }()
    
    var answersLabel: UILabel = {
        var answerLbl = UILabel()
        answerLbl.translatesAutoresizingMaskIntoConstraints = false
        answerLbl.font = UIFont.systemFont(ofSize: 24)
        answerLbl.text = "ANSWERS"
        answerLbl.numberOfLines = 0
        answerLbl.backgroundColor = #colorLiteral(red: 0.4992665052, green: 0.777181685, blue: 1, alpha: 1)
        return answerLbl
    }()
    
    var currentAnswer: UITextField = {
        var currentAns = UITextField()
        return currentAns
    }()
    
    var scoreLabel: UILabel = {
        var scoreLbl = UILabel()
        scoreLbl.translatesAutoresizingMaskIntoConstraints = false
        scoreLbl.textAlignment = .right
        scoreLbl.text = "Score: 0"
        return scoreLbl
    }()
    
    var letterButtons = [UIButton]()
    
    
    override func loadView() {
        view = UIView()
        view.backgroundColor = .white
        
    }
    
    func addSubviews(){
        view.addSubview(scoreLabel)
        view.addSubview(cluesLabel)
        view.addSubview(answersLabel)
    }
    
    func addContraints(){
        NSLayoutConstraint.activate([
            scoreLabel.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor),
            scoreLabel.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor),
            cluesLabel.topAnchor.constraint(equalTo: scoreLabel.bottomAnchor),
            cluesLabel.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor, constant: 100),
            cluesLabel.widthAnchor.constraint(equalTo: view.layoutMarginsGuide.widthAnchor, multiplier: 0.6, constant: -100),
            answersLabel.topAnchor.constraint(equalTo: scoreLabel.bottomAnchor),
            answersLabel.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor, constant: -100),
            answersLabel.widthAnchor.constraint(equalTo: view.layoutMarginsGuide.widthAnchor, multiplier: 0.4, constant: -100),
            answersLabel.heightAnchor.constraint(equalTo: cluesLabel.heightAnchor)
            ])}

    
    override func viewDidLoad() {
        addSubviews()
        addContraints()
        
        super.viewDidLoad()


    }


}

