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

    let cluesLabel: UILabel = {
        var cluesLbl = UILabel()
        cluesLbl.translatesAutoresizingMaskIntoConstraints = false
        cluesLbl.font = UIFont.systemFont(ofSize: 24)
        cluesLbl.text = "CLUES"
        cluesLbl.backgroundColor = #colorLiteral(red: 0.60072124, green: 1, blue: 0.3980069458, alpha: 1)
        cluesLbl.numberOfLines = 0
        cluesLbl.setContentHuggingPriority(UILayoutPriority(1), for: .vertical)
        return cluesLbl
    }()
    
    let answersLabel: UILabel = {
        var answerLbl = UILabel()
        answerLbl.translatesAutoresizingMaskIntoConstraints = false
        answerLbl.font = UIFont.systemFont(ofSize: 24)
        answerLbl.text = "ANSWERS"
        answerLbl.numberOfLines = 0
        answerLbl.textAlignment = .right
        answerLbl.backgroundColor = #colorLiteral(red: 0.4992665052, green: 0.777181685, blue: 1, alpha: 1)
        answerLbl.setContentHuggingPriority(UILayoutPriority(1), for: .vertical)
        return answerLbl
    }()
    
    let currentAnswer: UITextField = {
        var currentAns = UITextField()
        currentAns.translatesAutoresizingMaskIntoConstraints = false
        currentAns.placeholder = "Tap letters to guess"
        currentAns.textAlignment = .center
        currentAns.font = UIFont.systemFont(ofSize: 44)
        currentAns.isUserInteractionEnabled = false
        return currentAns
    }()
    
    let scoreLabel: UILabel = {
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
        let subBtn = UIButton(type: .system)
        subBtn.translatesAutoresizingMaskIntoConstraints = false
        subBtn.setTitle("SUBMIT", for:  .normal)
        subBtn.addTarget(self, action: #selector(submitTapped), for: .touchUpInside)
        return subBtn
    }()
    
    let clear: UIButton = {
        let clearBtn = UIButton(type: .system)
        clearBtn.translatesAutoresizingMaskIntoConstraints = false
        clearBtn.setTitle("CLEAR", for: .normal)
        clearBtn.addTarget(self, action: #selector(clearTapped), for: .touchUpInside)
        return clearBtn
    }()
    
    let buttonsView: UIView = {
        let btnsView = UIView()
        btnsView.translatesAutoresizingMaskIntoConstraints = false
        btnsView.backgroundColor = #colorLiteral(red: 0.9540640712, green: 1, blue: 0.3262510002, alpha: 1)
        return btnsView
    }()
    
    // ARRAY OF LETTER BUTTONS
    var letterButtons = [UIButton]()
    var activatedButtons = [UIButton]()
    var solutions = [String]()
    var score = 0
    var level = 1
    
    
    override func loadView() {
        view = UIView()
        view.backgroundColor = .white
        addSubviews()
        addContraints()
        make20Buttons()
        
    }
    
    func addSubviews(){
        view.addSubview(scoreLabel)
        view.addSubview(cluesLabel)
        view.addSubview(answersLabel)
        view.addSubview(currentAnswer)
        view.addSubview(submit)
        view.addSubview(clear)
        view.addSubview(buttonsView)
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
    
    func make20Buttons(){
        let width = 150
        let height = 80
        for row in 0..<4 {
            for column in 0..<5 {
                let letterButton = UIButton(type: .system)
                letterButton.titleLabel?.font = UIFont.systemFont(ofSize: 36)
                letterButton.setTitle("WWW", for: .normal)
                letterButton.addTarget(self, action: #selector(letterTapped), for: .touchUpInside)
                let frame = CGRect(x: column * width, y: row * height, width: width, height: height)
                letterButton.frame = frame
                buttonsView.addSubview(letterButton)
                letterButtons.append(letterButton)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        loadLevel()
    }
    
    @objc func letterTapped(_sender: UIButton){
        
    }
    
    @objc func submitTapped(_ sender: UIButton){
        
    }
    
    @objc func clearTapped(_ sender: UIButton){
        
    }
    
    func loadLevel() {
        var clueString = ""
        var solutionString = ""
        var letterBits = [String]()
        
        if let levelFileURL = Bundle.main.url(forResource: "level\(level)", withExtension: "txt") {
            if let levelContents = try? String(contentsOf: levelFileURL){
                var lines = levelContents.components(separatedBy: "\n")
                lines.shuffle()
                
                for (index, line) in lines.enumerated() {
                    let parts = line.components(separatedBy: ": ")
                    let answer = parts[0]
                    let clue = parts[1]
                    clueString += "\(index + 1). \(clue)\n"
                    let solutionWord = answer.replacingOccurrences(of: "|", with: "")
                    solutionString += "\(solutionWord.count) letters\n"
                    solutions.append(solutionWord)
                    
                    let bits = answer.components(separatedBy: "|")
                    letterBits += bits
                }
            }
        }
        cluesLabel.text = clueString.trimmingCharacters(in: .whitespacesAndNewlines)
        answersLabel.text = solutionString.trimmingCharacters(in: .whitespacesAndNewlines)
        letterButtons.shuffle()
        
        if letterButtons.count == letterBits.count{
            for i in 0..<letterButtons.count {
                letterButtons[i].setTitle(letterBits[i], for: .normal)
            }
        }
    }

}

