//
//  TitleTableViewController.swift
//  WebBrowserApp
//
//  Created by Ociel Lerma on 3/30/19.
//  Copyright © 2019 Ociel Lerma. All rights reserved.
//

import UIKit

class TitleTableViewController: UITableViewController {

    let websites = Websites()

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Select a website link"
    }
    
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return websites.getWebsiteCount()
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CELL", for: indexPath)
        cell.textLabel?.text = websites.websites[indexPath.row]
        return cell
    }

    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "SHOW_DETAIL")
                    as? ViewController {
            vc.detailWebesites = websites.websites[indexPath.row]
            navigationController?.pushViewController(vc, animated: true)
        }
        
        
    }


}
