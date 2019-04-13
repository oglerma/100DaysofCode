//
//  MainViewController.swift
//  Whitehouse Petition (Parsing JSON)
//
//  Created by Ociel Lerma on 4/11/19.
//  Copyright © 2019 Ociel Lerma. All rights reserved.
// https://www.ioscreator.com/tutorials/add-search-table-view-ios-tutorial
// https://www.youtube.com/watch?v=6ZnMXzJ-rKM
import UIKit

class MainViewController: UITableViewController, UISearchBarDelegate {
    
    var petitions = [Petition]()
    var searchBar: UISearchBar = UISearchBar()
    var filteredArray = [Petition]()
    var isSearching = false
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadURL()
        addNavigationItems()
    }
    // Navigation Items
    func addNavigationItems(){
        
        let shareCreditsBtn = UIBarButtonItem(barButtonSystemItem: .action,
                                              target: self,
                                              action: #selector(displayWebsiteCredits))
        navigationItem.leftBarButtonItem = shareCreditsBtn
        addSearchBar()
    }
    // Search Bar
    func addSearchBar(){
        searchBar.searchBarStyle = UISearchBar.Style.prominent
        searchBar.placeholder = " Search..."
        searchBar.sizeToFit()
        searchBar.isTranslucent = false
        searchBar.backgroundImage = UIImage()
        searchBar.delegate = self
        navigationItem.titleView = searchBar
    }
    func searchBar(_ searchBar: UISearchBar, textDidChange textSearched: String)
    {
        // MARK: Filter Syntax
        // Get the Word
        // Filter the Petittions array for petitions that contain that word
        // display filtered tableview
        isSearching = true
        filteredArray += petitions.filter({ print($0.body.lowercased()); return $0.body.lowercased() == searchBar.text?.lowercased()})
//        print("This is searcBar.text: \(String(describing: searchBar.text))")
        print("This is filteredArray: \(filteredArray)")
//        print("This is petitionsab: \(petitions)")
        tableView.reloadData()
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
    
    
    // MARK: Change this to include filtered words
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isSearching {
            return filteredArray.count
        }else{
            return petitions.count
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        if isSearching {
            cell.textLabel?.text = filteredArray[indexPath.row].title
            cell.detailTextLabel?.text = filteredArray[indexPath.row].body
        }else {
            cell.textLabel?.text = petitions[indexPath.row].title
            cell.detailTextLabel?.text = petitions[indexPath.row].body
        }
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
