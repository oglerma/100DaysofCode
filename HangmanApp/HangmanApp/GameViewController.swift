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

    override func viewDidLoad() {
        super.viewDidLoad()
        performSelector(inBackground: #selector(loadImages), with: nil)
    }
    
    // TODO: Load images into a string array (use performSelector for background threading)
    @objc private func loadImages(){
        let fm = FileManager.default
        let path = Bundle.main.resourcePath!
        let items = try! fm.contentsOfDirectory(atPath: path)
        for item in items {
            if item.hasPrefix("pic"){
                hangmanPictures.append(item)
                print(hangmanPictures)
            }
        }
    }
    // TODO: Set anchors for the images.
    // TODO: Get File or get data from a website that has words (use .userInteractive for our Deque)
    // TODO: Get a random word for user to guess
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
