//
//  GameViewController.swift
//  HangmanApp
//
//  Created by Ociel Lerma on 4/26/19.
//  Copyright © 2019 oglerma. All rights reserved.
//

import UIKit

class GameViewController: UIViewController {
    
    // PROPERTIES
    var hangmanPictures = [String]()
    var correctWord_underscore = [String]()
    var correctWord_random = ""
    var allWords = [String]()
    var letterBtns = [UIButton]()
    var emptyCorrectBoolArray = [Bool]()
    var updatedWord = ""
    
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

    //MARK: VERTICAL (PORTRAIT MODE)
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
    
    //MARK: CREATING BUTTONS
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
            button.layer.cornerRadius = 10
            button.addTarget(self, action: #selector(tappedABCbtns), for: .touchUpInside)
            button.setTitle(letter, for: .normal)
            button.setTitleColor( .blue , for: .normal)
            button.layer.borderWidth = 1
            return button
        }
    }
    
    //MARK: LOGIC OF THE GAME
    @objc private func tappedABCbtns(_ sender: UIButton){
        print("Inside button \(sender.titleLabel?.text ?? "inside")")
        guard let letter = sender.titleLabel?.text else {return}
        compareUserButtonWithAnswer(letter: letter)
        sender.setTitle("", for: .normal)
        sender.backgroundColor = #colorLiteral(red: 0.6052258744, green: 0.6052258744, blue: 0.6052258744, alpha: 1)
        sender.isUserInteractionEnabled = false
    }
    func compareUserButtonWithAnswer(letter: String){
        for (index, char) in correctWord_random.enumerated() {
            print("Index: \(index) and char \(char) inside of correctWord_random: \(correctWord_random)")
            if letter == String(char) {
                emptyCorrectBoolArray[index] = true
            }
        }
        makeUpdatedArray()
    }
    
    func makeUpdatedArray(){
        for (index, value) in correctWord_random.enumerated() {
            print("Index: \(index) and value \(value) inside of correctWord_random: \(correctWord_random)")
            if emptyCorrectBoolArray[index] {
                updatedWord += String(value) + " "
            } else {
                updatedWord += "⏤ "
            }
        }
        answerUITextField.text = updatedWord
        updatedWord = ""
    }
    

    

    
    private func addViews(){
        view.addSubviews(hangmanImage, answerUITextField, abcBtnView)
        
    }
    
    func createUnderscoreForGuessing(){
        let underScore = "⏤ "
        for letter in correctWord_random {
            correctWord_underscore.append(underScore)
            emptyCorrectBoolArray.append(false)
            answerUITextField.text! += underScore
            print(letter)
        }
        print(correctWord_underscore)
        
    }
    

    
    func startGame(){
        makeABCbtns()
        correctWord_random = allWords.randomElement()?.uppercased() ?? "Turtle"
        createUnderscoreForGuessing()
        
        // Zero out everything
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        performSelector(inBackground: #selector(loadImages), with: nil)
        loadWordList()
        addViews()
        addAnchors()
        startGame()
    }
    

}


// TODO: LOGIC of the game. Compare the user input answer with each letter in the answer and display
//       them in the view if they are correct.
// TODO: Iterate through the next picture if the user gets it wrong.
// TOOD: When user wins show a You WON screen with a button to start again. (Possibliy include a happy
//       hangman gif. 😃
