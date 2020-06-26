//
//  BJWCitiesListViewController.swift
//  AirQuality ObjC
//
//  Created by Bryan Workman on 6/25/20.
//  Copyright © 2020 RYAN GREENBURG. All rights reserved.
//

import UIKit

class BJWCitiesListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    

    @IBOutlet weak var tableView: UITableView!
    
    var country: String?
    var state: String?
    var cities: [String] = [] {
        didSet {
            updateTableView()
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        
        guard let state = state else {return}
        guard let country = country else {return}
        BJWCityAirQualityController.fetchSupportedCities(inState: state, country: country) { (cityResult) in
            guard let cityResult = cityResult else {return}
            self.cities = cityResult
        }
        
    }

    
    func updateTableView() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cities.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cityCell", for: indexPath)
        let city = cities[indexPath.row]
        cell.textLabel?.text = city
        
        return cell
    }

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toCityDetailVC" {
            guard let indexPath = tableView.indexPathForSelectedRow else {return}
            guard let destinationVC = segue.destination as? BJWCityDetailsViewController else {return}
            let city = cities[indexPath.row]
            
            destinationVC.city = city
            destinationVC.state = state
            destinationVC.country = country
        }
    }
    

}
