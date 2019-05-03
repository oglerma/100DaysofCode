//
//  GameViewController.swift
//  HangmanApp
//
//  Created by Ociel Lerma on 4/26/19.
//  Copyright © 2019 oglerma. All rights reserved.
//

import UIKit

class GameViewController: UIViewController {
    
    var hangmanPictures = [String]()
    var correctWord_underscore = [String]()
    var correctWord_random = ""
    var allWords = [String]()
    var letterBtns = [UIButton]()
    
    var stackView: UIStackView = {
        var stv = UIStackView()
        
        return stv
    }()
    
    var answerUITextField: UITextField = {
        let answerUItxtField = UITextField()
        answerUItxtField.isUserInteractionEnabled = false
        answerUItxtField.backgroundColor = .green
        answerUItxtField.textAlignment = .center
        return answerUItxtField
    }()
    
    var hangmanImage: UIImageView = {
        var hmImg = UIImageView()
        hmImg.setContentHuggingPriority(UILayoutPriority(1), for: .vertical)
        hmImg.image = UIImage(named: "pic1")
        return hmImg
    }()
    
    var abcBtnView: UIView = {
        var abcBtn = UIView()

        return abcBtn
    }()

    // TODO: Load images into a string array (use performSelector for background threading)
    @objc private func loadImages(){
        let fm = FileManager.default
        let path = Bundle.main.resourcePath!
        let items = try! fm.contentsOfDirectory(atPath: path)
        for item in items {
            if item.hasPrefix("pic"){
                hangmanPictures.append(item)
                
            }
        }
    }
    
    private func loadWordList(){
        if let wordsFileURL = Bundle.main.url(forResource: "words", withExtension: "txt"){
            if let data = try? String(contentsOf: wordsFileURL) {
                allWords.append(contentsOf: data.components(separatedBy: "\n"))
            }
        }
    }

    private func makeABCbtns(){
        let list = [["A", "B", "C", "D", "E"],
                    ["F", "G", "H", "I", "J"],
                    ["K","L", "M", "N", "O"],
                    ["P", "Q","R", "S", "T"],
                    ["U", "V", "W","X", "Y"],
                    ["Z"]]
        var groups = [UIStackView]()
        
        for i in list {
            let group = createButtons(named: i)
            let subStackView = UIStackView(arrangedSubviews: group)
            subStackView.axis = .horizontal
            subStackView.distribution = .fillEqually
            subStackView.spacing = 4
            groups.append(subStackView)
        }
        
        let stackView = UIStackView(arrangedSubviews: groups)
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.spacing = 4
        abcBtnView.addSubview(stackView)
        
        stackView.anchor(top: abcBtnView.topAnchor,
                         leading: abcBtnView.leadingAnchor,
                         bottom: abcBtnView.bottomAnchor,
                         trailing: abcBtnView.trailingAnchor,
                         centerXaxis: nil,
                         centerYaxis: nil,
                         padding: .init(top: 4, left: 4, bottom: 4, right: 4))
    }
    
    func createButtons(named: [String]) -> [UIButton]{
        return named.map { letter in
            let button = UIButton()
            button.translatesAutoresizingMaskIntoConstraints = false
            button.setTitle(letter, for: .normal)
            button.setTitleColor( .blue , for: .normal)
            button.layer.borderWidth = 1
            return button
        }
    }

    
    func compareUserButtonWithAnswer(){
        // Grab the button text that was just pressed and
        // search through the correct answer
        // look into the underscore array and replace the location of whtere the
        //      string charact3er was found. If there are more than one character
        //      then go again similar then go again.
        // Display the new updated array.
    }
    
    @objc private func tappedABCbtns(){
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        performSelector(inBackground: #selector(loadImages), with: nil)
        loadWordList()
        addViews()
        addAnchors()
        makeABCbtns()
        startGame()
    }
    
    private func addViews(){
        view.addSubviews(hangmanImage, answerUITextField, abcBtnView)
        
    }
    
    // VERTICAL (PORTRAIT MODE)
    private func addAnchors(){
        hangmanImage.anchor(top: view.safeAreaLayoutGuide.topAnchor,
                            leading: nil,
                            bottom: nil,
                            trailing: nil,
                            centerXaxis: view.centerXAnchor,
                            centerYaxis: nil,
                            padding:.init(top: 40, left: 0, bottom: 0, right: 0),
                            size: .init(width: 200, height: 200))
        answerUITextField.anchor(top: hangmanImage.bottomAnchor,
                                 leading: view.leadingAnchor,
                                 bottom: nil,
                                 trailing: view.trailingAnchor,
                                 centerXaxis: nil,
                                 centerYaxis: nil,
                                 padding: .init(top: 10, left: 15, bottom: 0, right: 15),
                                 size: .init(width: 0, height: 30))
        abcBtnView.anchor(top: answerUITextField.bottomAnchor,
                          leading: view.leadingAnchor,
                          bottom: view.safeAreaLayoutGuide.bottomAnchor,
                          trailing: view.trailingAnchor,
                          centerXaxis: nil,
                          centerYaxis: nil,
                          padding: .init(top: 10, left: 0, bottom: 10, right: 0))
    }
    // HORIZONTAL (LANDSCAPE MODE)
    private func addLandscapeModeAnchors(){
        
    }
    
    func createUnderscoreForGuessing(){
        let underScore = "⏤ "
        for letter in correctWord_random {
            correctWord_underscore.append(underScore)
            answerUITextField.text! += underScore
            print(letter)
        }
        print(correctWord_underscore)
        
    }
    

    
    func startGame(){
        correctWord_random = allWords.randomElement() ?? "Turtle"
        createUnderscoreForGuessing()
        
        
        
    }
    

    // TOOD: Change contraint sizes
    // TODO: Make empty underscores (possibly UILabels or Textfield) where words appears after being guessed.
    // TOOD: Set the number of underscore labels with the correct amount based on the right answer.
    // TODO: Set anchors labels, below the image.
    // TODO: Make Letter Buttons using possibly the entire abc's
    // TODO: Set anchors for the Letter buttons
    // TODO: LOGIC of the game. Compare the user input answer with each letter in the answer and display
    //       them in the view if they are correct.
    // TODO: Iterate through the next picture if the user gets it wrong.
    // TOOD: When user wins show a You WON screen with a button to start again. (Possibliy include a happy
    //       hangman gif. 😃
}

