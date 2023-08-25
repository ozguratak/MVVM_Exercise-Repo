//
//  AddWeatherCityViewController.swift
//  Exercise 3
//
//  Created by Özgür  Atak  on 23.08.2023.
//

import Foundation
import UIKit

protocol AddWeatherDelegate {
    func addWeatherDidSave(vm: WeatherViewModel)
}

class AddWeatherCityViewController: UIViewController {
    private var addWeatherVM = AddWeatherViewModel()
    var delegate: AddWeatherDelegate?
    @IBOutlet weak var cityTextField: UITextField!
    
    @IBAction func saveButtonPressed() {
        if let city = cityTextField.text {
            addWeatherVM.addWeather(for: city) { viewModel in
                self.delegate?.addWeatherDidSave(vm: viewModel)
                self.dismiss(animated: true, completion: nil)
            }
        }
        
    }

    @IBAction func closeButtonPressed() {
        self.dismiss(animated: true, completion: nil)
    }
    
   
    
}
