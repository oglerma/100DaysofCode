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
   
    var highScoreSaved = 0
    var bestScore = 0
    var beatBestScore = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadSavedInformation()
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
    func showUserBeatHighScore(){
        let ac = UIAlertController(title: "You Beat you Previous High score of \(bestScore) by \(bestScore - highScoreSaved)",
            message: "Keep going Champ!",
            preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "Continue", style: .default))
        present(ac, animated: true)
    }
    
    func loadSavedInformation(){
        let defaults = UserDefaults.standard
        if let savedHighScoreData = defaults.object(forKey: "highScoreSaved") as? Data{
            let jsonDecoder = JSONDecoder()
            do{
                let currentScoreSaved = try jsonDecoder.decode(Int.self, from: savedHighScoreData)
                // The Best score will be used to always keep the highest number we have ever gotten
                if currentScoreSaved < bestScore {
                    highScoreSaved = currentScoreSaved
                }else {
                    highScoreSaved = currentScoreSaved
                    bestScore = currentScoreSaved
                }
            }catch{
                print("Couldn't decode the highScoreSaved")
            }
        }
    }

    @IBAction func buttonTapped(_ sender: UIButton) {
        numberOfQuestionsAsked += 1
        


        print("This is best score \(bestScore)")
        print("This is beatBestscore \(beatBestScore)")
        if numberOfQuestionsAsked >= 10{
            if score > bestScore && !(bestScore <= 0) {
                showUserBeatHighScore()
            }
            showFinalAlert()
            print("Showed final alert already")
        }else {
            
            UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 5, options: [], animations: {
                sender.transform = CGAffineTransform(scaleX: 0.75, y: 0.75)
            }) { (fishished) in
                sender.transform = .identity
                self.showScoreAlert(buttonTagNumber: sender.tag)
            }
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
    
    func save(){
        let jsonEncoder = JSONEncoder()
        if let savedHighScore = try? jsonEncoder.encode(highScoreSaved){
            let defaults = UserDefaults.standard
            defaults.set(savedHighScore, forKey: "highScoreSaved")
        } else {
            print("Can't save high score")
        }
    }
    /***************************************************
     * SAVE() Explaniation
     *          We need to convert the highScoreSaved integer to a Data type so that we can save
     *          it in the UserDefaults. We could have made set the variable in a class or struct and
     *          made it conform to the codable protocol but we can also just handle it right here with
     *          JSONEncoder(). THis will encode our Integer, making it a Data type, and will be able
     *          to give it a key so that we can access it wheverver we want after it is saved.
     *          So we first Instantiate a JSONEndoer type.
     *          Then we try to encode the highScoreSaved Integer, conveniently with a try statment.
     *          if it converts it to Data type then we set it to our user Defaults. We can easilty just say
     *          Userdefault.standard.set(DATA Type in this case highScoreSaved, Key that you want to give it)
     *          Now it is saved in user defaults. To retrieve this information when we relaunch the app, we need to
     *          basically go to our USerdefaults and check to see if the highScoreSaved Data that we saved is there.
     *          since we gave it a key word we can check if it is there and assign it back the the property that it
     *          belongs to. Since it in the begining that it does this then everything will be updated as it previosly was
     *          before we shut the app.
     ***************************************************/

    
}
