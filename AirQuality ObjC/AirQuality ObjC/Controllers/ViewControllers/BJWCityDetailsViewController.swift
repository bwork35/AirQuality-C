//
//  BJWCityDetailsViewController.swift
//  AirQuality ObjC
//
//  Created by Bryan Workman on 6/25/20.
//  Copyright © 2020 RYAN GREENBURG. All rights reserved.
//

import UIKit
import Foundation

class BJWCityDetailsViewController: UIViewController {

    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var stateLabel: UILabel!
    @IBOutlet weak var countryLabel: UILabel!
    @IBOutlet weak var AQILabel: UILabel!
    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var humidityLabel: UILabel!
    @IBOutlet weak var windspeedLabel: UILabel!
    
    
    var country: String?
    var state: String?
    var city: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        guard let country = country,
        let state = state,
        let city = city else {return}
        BJWCityAirQualityController.fetchData(forCity: city, state: state, country: country) { (cityDetailResult) in
            guard let cityDetailResult = cityDetailResult else {return}
            DispatchQueue.main.async {
                self.cityLabel.text = cityDetailResult.city
                self.stateLabel.text = cityDetailResult.state
                self.countryLabel.text = cityDetailResult.country
                self.AQILabel.text = "\(cityDetailResult.pollution.airQualityIndex) US AQI"
                self.tempLabel.text = "\(cityDetailResult.weather.temperature) degrees (C)"
                self.humidityLabel.text = "\(cityDetailResult.weather.humidity)% humidity"
                self.windspeedLabel.text = "\(cityDetailResult.weather.windspeed)mph"
            }
        }
    }
}
