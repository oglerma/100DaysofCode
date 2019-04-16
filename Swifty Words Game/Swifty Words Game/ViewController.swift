//
//  ViewController.swift
//  Swifty Words Game
//
//  Created by Ociel Lerma on 4/13/19.
//  Copyright © 2019 Ociel Lerma. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    /***************************************************
     * ADDING OUR VIEWS AS COMPUTED PROPERTIES
     * I.E. (CLUESLABEL, ANSWERSLABEL, CURRENTANSWER, AND SCORELABEL)
     ***************************************************/

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
        answerLbl.textAlignment = .right
        answerLbl.backgroundColor = #colorLiteral(red: 0.4992665052, green: 0.777181685, blue: 1, alpha: 1)
        return answerLbl
    }()
    
    var currentAnswer: UITextField = {
        var currentAns = UITextField()
        currentAns.translatesAutoresizingMaskIntoConstraints = false
        currentAns.placeholder = "Tap letters to guess"
        currentAns.textAlignment = .center
        currentAns.font = UIFont.systemFont(ofSize: 44)
        currentAns.isUserInteractionEnabled = false
        return currentAns
    }()
    
    var scoreLabel: UILabel = {
        var scoreLbl = UILabel()
        scoreLbl.translatesAutoresizingMaskIntoConstraints = false
        scoreLbl.textAlignment = .right
        scoreLbl.text = "Score: 0"
        return scoreLbl
    }()
    
    /***************************************************
     * SUBMIT, CLEAR AND BUTTONSVIEW BUTTONS
     ***************************************************/
    let submit: UIButton = {
        let subBtn = UIButton()
        subBtn.translatesAutoresizingMaskIntoConstraints = false
        subBtn.setTitle("SUBMIT", for:  .normal)
        return subBtn
    }()
    
    let clear: UIButton = {
        let clearBtn = UIButton()
        clearBtn.translatesAutoresizingMaskIntoConstraints = false
        clearBtn.setTitle("CLEAR", for: .normal)
        return clearBtn
    }()
    
    let buttonsView: UIView = {
        let btnsView = UIView()
        btnsView.translatesAutoresizingMaskIntoConstraints = false
        return btnsView
    }()
    
    // ARRAY OF LETTER BUTTONS
    var letterButtons = [UIButton]()
    
    
    override func loadView() {
        view = UIView()
        view.backgroundColor = .white
        
    }
    
    func addSubviews(){
        view.addSubview(scoreLabel)
        view.addSubview(cluesLabel)
        view.addSubview(answersLabel)
        view.addSubview(currentAnswer)
        view.addSubview(submit)
        view.addSubview(clear)
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
            answersLabel.heightAnchor.constraint(equalTo: cluesLabel.heightAnchor),
            currentAnswer.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            currentAnswer.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.5),
            currentAnswer.topAnchor.constraint(equalTo: cluesLabel.bottomAnchor, constant: 20),
            submit.topAnchor.constraint(equalTo: currentAnswer.bottomAnchor),
            submit.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: -100),
            submit.heightAnchor.constraint(equalToConstant: 44),
            clear.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 100),
            clear.centerYAnchor.constraint(equalTo: submit.centerYAnchor),
            clear.heightAnchor.constraint(equalToConstant: 44),
            buttonsView.widthAnchor.constraint(equalToConstant: 750),
            buttonsView.heightAnchor.constraint(equalToConstant: 320),
            buttonsView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            buttonsView.topAnchor.constraint(equalTo: submit.bottomAnchor, constant: 20),
            buttonsView.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor, constant: -20)
            ])}

    
    override func viewDidLoad() {
        addSubviews()
        addContraints()
        
        super.viewDidLoad()


    }


}

