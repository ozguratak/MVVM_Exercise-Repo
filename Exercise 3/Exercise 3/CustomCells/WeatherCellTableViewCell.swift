//
//  WeatherCellTableViewCell.swift
//  Exercise 3
//
//  Created by Özgür  Atak  on 24.08.2023.
//

import UIKit

class WeatherCellTableViewCell: UITableViewCell {

    @IBOutlet weak var pressureDataLabe: UILabel!
    @IBOutlet weak var humidtyDataLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var pressureLabel: UILabel!
    @IBOutlet weak var humidtyLabel: UILabel!
    @IBOutlet weak var cityNameLabel: UILabel!
    
    
    func configure(vm: WeatherViewModel) {
        
        cityNameLabel.text = vm.city
        if SettingsViewModel().selectedUnit.displayName == "Celcius" {
            temperatureLabel.text = String(describing: vm.temp.formatAsDegree()) + "C°"
        } else {
            temperatureLabel.text = String(describing: vm.temp.formatAsDegree()) + "F°"
        }
        
        humidtyLabel.text = "Humdity"
        if let humidty = vm.weather.main.humidty {
            humidtyDataLabel.text = "% " + String(describing: humidty)
        } else {
            humidtyDataLabel.text = "No data"
        }
        
        pressureLabel.text = "Pressure"
        if let pressure = vm.weather.main.pressure {
            pressureDataLabe.text = String(describing: pressure) + " mBar"
        } else {
            pressureDataLabe.text = "No data"
        }
        
    }
    
}
