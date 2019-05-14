//
//  CameraTableViewController.swift
//  CameraWithCaptions
//
//  Created by Ociel Lerma on 5/13/19.
//  Copyright © 2019 Ociel Lerma. All rights reserved.
//

import UIKit

class CameraTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        
    }


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }

  
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        cell.textLabel?.text = "Helloo"

        return cell
    }

}
