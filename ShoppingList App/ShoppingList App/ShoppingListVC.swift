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
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(askForItem))
        title = "Shopping List"
        // TODO: Add a delete swipe
        makeNewList()
    }

   @objc func askForItem(){
        
        let ac = UIAlertController(title: "Add an Item", message: nil, preferredStyle: .alert)
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
    
    
    // Swipe and delete is already a built in method in tableview
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        // Checks to see if it was swiiped. If it is it will delete where the swipe was
        // by removing the value inside the cell at indexPath.row of the shoppingListArray.
        if editingStyle == UITableViewCell.EditingStyle.delete{
            shoppingListArray.remove(at: indexPath.row)
        }
        tableView.reloadData()
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return shoppingListArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ShoppingCell", for: indexPath)
        cell.textLabel?.text = shoppingListArray[indexPath.row]
        return cell
    }
 
    


}
