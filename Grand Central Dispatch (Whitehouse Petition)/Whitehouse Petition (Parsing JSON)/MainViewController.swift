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
    var customSearchBar: UISearchBar = UISearchBar()
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
    // SEARCHBAR
    func addSearchBar(){
        customSearchBar.searchBarStyle = UISearchBar.Style.prominent
        customSearchBar.placeholder = " Search for title..."
        customSearchBar.sizeToFit()
        customSearchBar.isTranslucent = false
        customSearchBar.backgroundImage = UIImage()
        customSearchBar.delegate = self
        navigationItem.titleView = customSearchBar
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange textSearched: String)
    {
        if searchBar.text! == "" {
            isSearching = false
            
        }else{
            isSearching = true
            filteredArray = petitions.filter({return $0.title.contains(searchBar.text!)})
        }
        tableView.reloadData()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        customSearchBar.text = ""
        isSearching = false
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
        
        DispatchQueue.global(qos: .userInitiated).async { [weak self] in
            if let url = URL(string: urlString) {
                if let data = try? Data(contentsOf: url) {
                    // we're OK to parse!
                    self?.parse(json: data)
                    return
                }
            }
            self?.showError()
        }
        
        
    }

    func parse(json: Data) {
        let decoder = JSONDecoder()
        
        if let jsonPetitions = try? decoder.decode(Petitions.self, from: json) {
            petitions = jsonPetitions.results
            DispatchQueue.main.async { [weak self] in
                self?.tableView.reloadData()
            }
           
        }
    }
    
    
    // MARK: Change this to include filtered words
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isSearching {
            print("Inside the first numberOfRowsInSection")
            return filteredArray.count
            
        }else{
            print("Inside the Second numberOfRowsInSection")
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
        if isSearching{
            vc.detailItem = filteredArray[indexPath.row]
        } else{
            vc.detailItem = petitions[indexPath.row]
        }
        navigationController?.pushViewController(vc, animated: true)
    }
    
    
    func showError(){
        DispatchQueue.main.async { [weak self] in
            let ac = UIAlertController(title: "Loading error",
                                       message: "There was a problem loading your data;\n please try again ",
                                       preferredStyle: .alert)
            let action = UIAlertAction(title: "OK", style: .cancel)
            ac.addAction(action)
            self?.present(ac,animated: true)
        }

    }
    
}
