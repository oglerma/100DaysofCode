//
//  ShoppingListVC.swift
//  ShoppingList App
//
//  Created by Ociel Lerma on 4/8/19.
//  Copyright © 2019 Ociel Lerma. All rights reserved.
//

import UIKit

class ShoppingListVC: UITableViewController {
    
    var shoppingListArray = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        // TODO: Add the Add an Item button
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(askForItem))
        // TODO: Add Alert ViewController that takes in text
        // TODO: Display Text From AlertVC into ShoppingListTableView
        // TODO: Add a Function to start a new list
        // TODO: Add a title in the Navigation bar
        title = "Shopping List"
        // TODO: Add a delete swipe
        makeNewList()
    }

   @objc func askForItem(){
        
        let ac = UIAlertController(title: "Add and Item", message: nil, preferredStyle: .alert)
        ac.addTextField()
        ac.addAction(UIAlertAction(title: "Add", style: .default) {
            //TODO: Study this more
            [weak self, weak ac] action in
            guard let answer = ac?.textFields?[0].text else {return}
            self?.submit(answer)
        })
            
        present(ac, animated: true)
    }
    
    func submit(_ answer: String){
        shoppingListArray.insert(answer, at: 0)
        let indexPath = IndexPath(row: 0, section: 0)
        tableView.insertRows(at: [indexPath], with: .automatic)
    }
    
    func makeNewList(){
        shoppingListArray.removeAll(keepingCapacity: true)
        tableView.reloadData()
    }
    
    
    
    // Rows and
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return shoppingListArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ShoppingCell", for: indexPath)
        cell.textLabel?.text = shoppingListArray[indexPath.row]
        return cell
    }
 
    


}
