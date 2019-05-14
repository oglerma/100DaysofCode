//
//  CameraTableViewController.swift
//  Camera Capture App
//
//  Created by Lerma, Ociel(AWF) on 5/14/19.
//  Copyright © 2019 oglerma. All rights reserved.
//

import UIKit

class CameraTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)

        // Configure the cell...
        cell.textLabel?.text = "hello"

        return cell
    }


}
