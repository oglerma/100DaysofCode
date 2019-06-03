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
        if let jsonCountries = try? decoder.decode([Country].self, from: json) {
            countriesArray = jsonCountries
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
        // Cat JPG
        let url = URL(string: "https://news.nationalgeographic.com/content/dam/news/2018/05/17/you-can-train-your-cat/02-cat-training-NationalGeographic_1484324.ngsversion.1526587209178.adapt.1900.1.jpg")
        vc.flagImageView.load(url: url!)
        vc.countryName.text    = "Country: " + countriesArray[indexPath.row].name + "    Population: \(countriesArray[indexPath.row].population)"
        vc.countryRegion.text  = "Region: " + countriesArray[indexPath.row].region
        vc.countryCapital.text = "Capital: " + countriesArray[indexPath.row].capital
        vc.view.backgroundColor = .white
        vc.title = countriesArray[indexPath.row].name

        navigationController?.pushViewController(vc, animated: true)
    }
    
    
}

struct Country: Codable {
    var name: String
    var capital: String
    var population: Int
    var region: String
    
}

extension UIImageView {
    func load(url: URL) {
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
}
