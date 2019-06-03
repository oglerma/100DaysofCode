//
//  CountriesViewController.swift
//  Countries_API
//
//  Created by Ociel Lerma on 6/1/19.
//  Copyright © 2019 Ociel Lerma. All rights reserved.
//

import UIKit

let cellId = "cellId"
class CountriesViewController: UITableViewController  {

    var countriesArray = [Country]()
    var imgView: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Select a Country"
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellId)
        loadURL()
    }
    

    func loadURL(){
        guard let url = URL(string: "https://restcountries.eu/rest/v2/all") else {return}
        if let data = try? Data(contentsOf: url) {
            parse(json: data)
        }
    }
    
    func parse(json: Data){
        let decoder = JSONDecoder()
        print("parse func called")
        if let jsonCountries = try? decoder.decode([Country].self, from: json) {
            countriesArray = jsonCountries
            print(countriesArray[0].name)
            print("Inside countriesArray: \(countriesArray.count)")
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return countriesArray.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath)
        let name = countriesArray[indexPath.row].name
        cell.textLabel?.text = name
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = DetailVC()
        
        navigationController?.pushViewController(vc, animated: true)
    }
    
    
}

struct Country: Codable {
    var name: String
    var capital: String
    var population: Int
    var region: String
    var flag: String
    
}




// Possibly loading an image from a URL
//let url = URL(string: "IMAGE URL HERE")
//let data = try? Data(contentsOf: url)
//
//if let imageData = data {
//    let image = UIImage(data: imageData)
//}
