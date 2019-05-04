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
    var emptyCorrectBoolArray = [Bool]()
    var updatedWord = ""
    var numberOfTries = 1
    var groups = [UIStackView]()
    
    var answerUITextField: UITextField = {
        let answerUItxtField = UITextField()
        answerUItxtField.isUserInteractionEnabled = false
        answerUItxtField.layer.cornerRadius = 7
        answerUItxtField.backgroundColor = #colorLiteral(red: 0.9568627477, green: 0.6588235497, blue: 0.5450980663, alpha: 1)
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
        abcBtn.backgroundColor =  #colorLiteral(red: 0.1785905659, green: 0.1944591999, blue: 0.3133455813, alpha: 0.8722766285)
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
                          bottom: view.bottomAnchor,
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
            button.backgroundColor = #colorLiteral(red: 0.5843137503, green: 0.8235294223, blue: 0.4196078479, alpha: 1)
            button.addTarget(self, action: #selector(tappedABCbtns), for: .touchUpInside)
            button.setTitle(letter, for: .normal)
            button.setTitleColor( .black , for: .normal)
            button.layer.borderWidth = 1
            return button
        }
    }
    
    //MARK: LOGIC OF THE GAME
    @objc private func tappedABCbtns(_ sender: UIButton){
        guard let letter = sender.titleLabel?.text else {return}
        compareUserButtonWithAnswer(letter: letter)
        sender.setTitle("", for: .normal)
        sender.backgroundColor = #colorLiteral(red: 0.6052258744, green: 0.6052258744, blue: 0.6052258744, alpha: 1)
        sender.isUserInteractionEnabled = false
    }
    func compareUserButtonWithAnswer(letter: String){
        if correctWord_random.contains(letter){
            for (index, char) in correctWord_random.enumerated() {
                if letter == String(char) {
                    emptyCorrectBoolArray[index] = true
                }
            }
            makeUpdatedArray()
        } else {
            updateHangmanImage()
        }
        

    }
    func makeUpdatedArray(){
        for (index, value) in correctWord_random.enumerated() {
            if emptyCorrectBoolArray[index] {
                updatedWord += String(value) + " "
            } else {
                updatedWord += "⏤ "
            }
        }
        answerUITextField.text = updatedWord
        
        // Checking to see if there is any underscore in the answer
        // if there is no underscore that means we won.
        if !(answerUITextField.text?.contains("⏤ "))!{
            youWon()
        }
        updatedWord = ""
        
    }
    
    
    func updateHangmanImage(){
        numberOfTries += 1
        hangmanImage.image = UIImage(named: "pic\(numberOfTries)")
        
        if numberOfTries == 6{
            gameOver()
        }
    
    }
    
    func gameOver(){
        // Disable buttons
        for btn in groups {
            btn.isHidden = true
        }
        
        let ac = UIAlertController(title: "Game Over", message: "You are dead!\n Want to play again?", preferredStyle: .actionSheet)
        ac.addAction(UIAlertAction(title: "OK", style: .default){
            [weak self](action) in
            self?.playAgain()
        })
        ac.addAction(UIAlertAction(title: "Nope", style: .default))
        present(ac,animated: true)
    }
    
    func youWon(){
        for btn in groups {
            btn.isHidden = true
        }
        
        let ac = UIAlertController(title: "You Won!", message: "You are great!\n Want to play again?", preferredStyle: .actionSheet)
        ac.addAction(UIAlertAction(title: "OK", style: .default){
            [weak self](action) in
            self?.playAgain()
        })
        ac.addAction(UIAlertAction(title: "Nope", style: .default))
        present(ac,animated: true)
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
        
    }
    

    
    func startGame(){
        makeABCbtns()
        correctWord_random = allWords.randomElement()?.uppercased() ?? "Turtle"
        createUnderscoreForGuessing()
        
    }
    func playAgain(){
        hangmanImage.image = UIImage(named: "pic1")
        correctWord_underscore.removeAll()
        emptyCorrectBoolArray.removeAll()
        numberOfTries = 1
        groups.removeAll()
        answerUITextField.text = ""
        startGame()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Hangman"
        view.backgroundColor = #colorLiteral(red: 0.9764705896, green: 0.850980401, blue: 0.5490196347, alpha: 1)
        performSelector(inBackground: #selector(loadImages), with: nil)
        loadWordList()
        addViews()
        addAnchors()
        startGame()
    }
    

}

