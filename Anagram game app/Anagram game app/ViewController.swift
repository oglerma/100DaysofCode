//
//  ViewController.swift
//  Anagram game app
//
//  Created by Ociel Lerma on 4/2/19.
//  Copyright © 2019 Ociel Lerma. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {
    
    var allWords = [String]()
    var usedWords = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
       
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add,
                                                            target: self,
                                                            action: #selector(promptForAnswer))
        loadWords()
        startGame()
        
    }
    
    // Search for txt file in project and load content into an array
    func loadWords(){
        if let startWordsURL = Bundle.main.url(forResource: "start", withExtension: "txt"){
            if let startWords = try? String(contentsOf: startWordsURL){
                allWords = startWords.components(separatedBy: "\n")
            }
        }
        if allWords.isEmpty {
            allWords = ["silkworm"]
        }
    }

    func startGame(){
        title = allWords.randomElement()
        usedWords.removeAll(keepingCapacity: true)
        
        // refreshes the current tableview controller
        tableView.reloadData()
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return usedWords.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Word", for: indexPath)
        cell.textLabel?.text = usedWords[indexPath.row]
        return cell
    }
    
    @objc func promptForAnswer(){
        let ac = UIAlertController(title: "Enter answer", message: nil, preferredStyle: .alert)
        ac.addTextField()
        
        // Using Trailing closures
        let submitAction = UIAlertAction(title: "Submit", style: .default){
            [weak self, weak ac] action in
            guard let answer = ac?.textFields?[0].text else { return }
            self?.submit(answer)
            
        }
        ac.addAction(submitAction)
        present(ac, animated: true)
        
    }
    
    func submit(_ answer: String){
        let lowerAnswer = answer.lowercased()
        if isPossible(word: lowerAnswer){
            if isOriginal(word: lowerAnswer){
                if isReal(word: lowerAnswer){
                    //Inserts word at the top and if there is a word
                    //already in then it scoots it to the next index.
                    usedWords.insert(lowerAnswer, at: 0)
                    
                    //Gets indexPath.row and give it a Zero so when we call
                    //the insertRows we can give it the first index and it
                    //will animate this. Another way around if we don't want
                    //to reload the entire project.
                    let indexPath = IndexPath(row: 0, section: 0)
                    tableView.insertRows(at: [indexPath], with: .automatic)
                }
            }
        }
        
    }
    
    func isPossible(word: String) -> Bool {
        guard var tempWord = title?.lowercased() else {return false}
        for letter in word{
            // Using .firstIndex looks inside of tempWord and checks to see
            // if the letter is inside of it. The first letter that looks like
            // letter will be then removed from the tempWord. If the entire loop
            // is able to proceed that means there was enough letters that are
            // found in the title that can be used whic is acceptable or in
            // other words it's possible.
            if let position = tempWord.firstIndex(of: letter){
                tempWord.remove(at: position)
            }else {
                return false
            }
        }
        return true
    }
    
    func isOriginal(word: String)-> Bool{
        return !usedWords.contains(word)
    }
    
    func isReal(word: String) -> Bool {
        let checker = UITextChecker()
        // Obj C syntax
        let range = NSRange(location: 0, length: word.utf16.count)
        let misspelledRange = checker.rangeOfMisspelledWord(in: word, range: range, startingAt: 0, wrap: false, language: "en")
        return misspelledRange.location == NSNotFound
    }
    
    

}

