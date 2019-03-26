//
//  ViewController.swift
//  Project3
//
//  Created by Lerma, Ociel(AWF) on 3/23/19.
//  Copyright © 2019 Lerma, Ociel(AWF). All rights reserved.
//

import UIKit

class ViewController: UITableViewController {

    var countries = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Share your Country"
        tableView.rowHeight = 90
        
        setCountries()
    }

    private func setCountries(){
        countries += ["estonia", "france", "germany", "ireland", "italy", "monaco", "nigeria", "poland", "russia", "spain", "uk", "us"]
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return countries.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell  = tableView.dequeueReusableCell(withIdentifier: "Country", for: indexPath)
        cell.textLabel?.text = countries[indexPath.row]
        cell.imageView?.image = UIImage(named: countries[indexPath.row])
        return cell
        
    }
    
    
    //Populate the Detail view controler and show the next view controller.
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        if let vc = storyboard?.instantiateViewController(withIdentifier: "Detail") as? DetailViewController {
            vc.loadedPicture = UIImage(named: countries[indexPath.row])
            vc.nameOfTheCountry = countries[indexPath.row]
            navigationController?.pushViewController(vc, animated: true)
        }
    }

}

