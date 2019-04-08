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
