//
//  MainViewController.swift
//  Whitehouse Petition (Parsing JSON)
//
//  Created by Ociel Lerma on 4/11/19.
//  Copyright © 2019 Ociel Lerma. All rights reserved.
// https://www.ioscreator.com/tutorials/add-search-table-view-ios-tutorial
// https://www.youtube.com/watch?v=6ZnMXzJ-rKM
import UIKit

class MainViewController: UITableViewController {
    
    var petitions = [Petition]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadURL()
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(displayWebsiteCredits))
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .search, target: nil, action: #selector(filterWord))
        // We need to input a word
        // use the word to filter through the input and only get
        // put the new filter into an array to use it
        // display the new filtered list
        
    }
    
    @objc
    func filterWord(){
        //Display an Alert controller with a text input type
        // get the info for
    }
    
    @objc
    func displayWebsiteCredits(){
        let userAC = UIAlertController(title: "Credits",
                                       message: "The Data provided comes from: \n www.hackingwithswift.com",
                                       preferredStyle: .alert)
        
        let action = UIAlertAction(title: "OK", style: .cancel)
        userAC.addAction(action)
        present(userAC, animated: true)
    }
    
    func loadURL(){
        
        let urlString: String
        
        // Switch between tabBarItems
        if navigationController?.tabBarItem.tag == 0{
            urlString = "https://www.hackingwithswift.com/samples/petitions-1.json"
        }else{
            urlString = "https://www.hackingwithswift.com/samples/petitions-2.json"
        }
        
        
        if let url = URL(string: urlString) {
            if let data = try? Data(contentsOf: url) {
                // we're OK to parse!
                parse(json: data)
                return 
            }
        }
        showError()
        
    }
    
    
    func parse(json: Data) {
        let decoder = JSONDecoder()
        
        if let jsonPetitions = try? decoder.decode(Petitions.self, from: json) {
            petitions = jsonPetitions.results
            tableView.reloadData()
        }
    }
    
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return petitions.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let petition = petitions[indexPath.row]
        cell.textLabel?.text = petition.title
        cell.detailTextLabel?.text = petition.body
        return cell
    }
    
    
    // Instantiate the ViewController that we are going to and pass it the selected Cell.
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = DetailViewController()
        vc.detailItem = petitions[indexPath.row]
        navigationController?.pushViewController(vc, animated: true)
    }
    
    
    func showError(){
        let ac = UIAlertController(title: "Loading error",
                                   message: "There was a problem loading your data;\n please try again ",
                                   preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .cancel)
        ac.addAction(action)
        present(ac,animated: true)
    }
    
}
