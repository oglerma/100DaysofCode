//
//  ViewController.swift
//  Project2
//
//  Created by Ociel Lerma on 3/11/19.
//  Copyright © 2019 Ociel Lerma. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var button1: UIButton!
    @IBOutlet var button2: UIButton!
    @IBOutlet var button3: UIButton!
    
    var countries: [String] = []
    var score = 0
    var correctAnswer = 0
    var numberOfQuestionsAsked = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // ADD BORDER RADIUS and COLOR
        var allButtons = [button1, button2, button3]
        for i in 0...allButtons.count - 1 {
            addBorderRadius(addBorder: allButtons[i])
            addCGColorToBorderWidth(borderColorBTN: allButtons[i])
        }
        
        
        countries += ["estonia", "france", "germany",
                      "ireland", "italy", "monaco",
                      "nigeria", "poland", "russia",
                      "spain", "uk", "us"]
        
        askQuestion()
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Score", style: .done, target: self, action: #selector(showScore))
    }

    @IBAction func buttonTapped(_ sender: UIButton) {
        numberOfQuestionsAsked += 1

        if numberOfQuestionsAsked >= 10{
            showFinalAlert()
        }else {
            showScoreAlert(buttonTagNumber: sender.tag)
        }
        print("This is the number of questions asked in buttonTapped = \(numberOfQuestionsAsked)")
        
        
        
    }
    
    func showFinalAlert(){
        let actionController = UIAlertController(title: "Game Over",
                                                 message: "Your final score was: \(score)",
            preferredStyle: .alert)
        let playAgainAction = UIAlertAction(title: "Play Again", style: .default, handler: resetGame)
        let cancelAction = UIAlertAction(title: "Cancel", style: .default){ (action: UIAlertAction!) in
            print("cancel item hit")
        }
        actionController.addAction(playAgainAction)
        actionController.addAction(cancelAction)
        present(actionController, animated: true)
    }
    
    func showScoreAlert(buttonTagNumber: Int){
        var title: String
        
        if buttonTagNumber == correctAnswer{
            title = "Correct"
            score += 1
        }else {
            title = "Wrong\n That is the flag for \(countries[buttonTagNumber])"
            score -= 1
        }
        
        let ac = UIAlertController(title: title, message: "Your score is \(score)", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "Continue", style: .default, handler: askQuestion))
        present(ac, animated: true)
        
    }
    
    func resetGame(action: UIAlertAction! = nil){
        score = 0
        correctAnswer = 0
        numberOfQuestionsAsked = 0
    }
    
    func askQuestion(action: UIAlertAction! = nil){
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
        
        button1.setImage(UIImage(named: countries[0]), for: .normal)
        button2.setImage(UIImage(named: countries[1]), for: .normal)
        button3.setImage(UIImage(named: countries[2]), for: .normal)
        
        title = countries[correctAnswer].uppercased() + " Score: \(score)"
        
        
    }
    
    @objc func showScore(){
        let showScoreAlert = UIAlertController(title: "Total Score", message: "Your Score is: \(score)", preferredStyle: .alert)
        showScoreAlert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        present(showScoreAlert, animated: true)
    }
    
    

    func addBorderRadius(addBorder borderBtn: UIButton?){
        borderBtn?.layer.borderWidth = 1
    }
    
    func addCGColorToBorderWidth(borderColorBTN: UIButton?){
        borderColorBTN?.layer.borderColor = UIColor.lightGray.cgColor
    }
}
