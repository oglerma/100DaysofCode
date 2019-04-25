//
//  MainViewController.swift
//  Whitehouse Petition (Parsing JSON)
//
//  Created by Ociel Lerma on 4/11/19.
//  Copyright © 2019 Ociel Lerma. All rights reserved.
// https://www.ioscreator.com/tutorials/add-search-table-view-ios-tutorial
// https://www.youtube.com/watch?v=6ZnMXzJ-rKM
// https://www.swiftbysundell.com/posts/a-deep-dive-into-grand-central-dispatch-in-swift

import UIKit

class MainViewController: UITableViewController, UISearchBarDelegate {
    
    var petitions = [Petition]()
    var customSearchBar: UISearchBar = {
        var custSB = UISearchBar()
        custSB.searchBarStyle = UISearchBar.Style.prominent
        custSB.placeholder = " Search for title..."
        custSB.sizeToFit()
        custSB.isTranslucent = false
        custSB.backgroundImage = UIImage()
        return custSB
    }()
    var filteredArray = [Petition]()
    var isSearching = false
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        performSelector(inBackground: #selector(fetchJSON), with: nil)
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
        customSearchBar.delegate = self
        navigationItem.titleView = customSearchBar
    }
    
    private var pendingRequestWorkItem: DispatchWorkItem?
    func searchBar(_ searchBar: UISearchBar, textDidChange textSearched: String)
    {
        pendingRequestWorkItem?.cancel()
        
        let requestWorkItem = DispatchWorkItem{
            [weak self] in
            if searchBar.text! == "" {
                self?.isSearching = false
                
            }else{
                self?.isSearching = true
                self?.filteredArray = (self?.petitions.filter({return $0.title.contains(searchBar.text!)}))!
            }
            
        }
        pendingRequestWorkItem = requestWorkItem
        DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(250),
                                      execute: requestWorkItem)
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
    
    @objc func fetchJSON(){
        
        let urlString: String
        // Switch between tabBarItems
        if navigationController?.tabBarItem.tag == 0 {
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
            // This function has UI so it has to run in the main thread not
            // in a background thread.
            performSelector(onMainThread: #selector(showError), with: nil, waitUntilDone: false)

        
        
    }

    func parse(json: Data) {
        let decoder = JSONDecoder()
        
        if let jsonPetitions = try? decoder.decode(Petitions.self, from: json) {
            petitions = jsonPetitions.results
            // It is not OK do do UI work in a background thread.
            // For that reason we are pushing the code to the main queue.
            tableView.performSelector(onMainThread: #selector(UITableView.reloadData), with: nil, waitUntilDone: false)
        } else {
            performSelector(onMainThread: #selector(showError), with: nil, waitUntilDone: false)
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
    
    
    @objc func showError(){
            let ac = UIAlertController(title: "Loading error",
                                       message: "There was a problem loading your data;\n please try again ",
                                       preferredStyle: .alert)
            let action = UIAlertAction(title: "OK", style: .cancel)
            ac.addAction(action)
            present(ac,animated: true)
        }
    
}
