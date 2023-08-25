//
//  SettingsViewModel.swift
//  Exercise 3
//
//  Created by Özgür  Atak  on 24.08.2023.
//

import Foundation

class SettingsViewModel {
    let units = Units.allCases
    
    var selectedUnit: Units {
        get {
            let userDefaults = UserDefaults.standard
            var unitValue = ""
            if let value = userDefaults.value(forKey: "unit") as? String {
                unitValue = value
            }
            return Units(rawValue: unitValue) ?? Units.metric
        }
        
        set {
            let userDefaults = UserDefaults.standard
            userDefaults.set(newValue.rawValue, forKey: "unit")
        }
    }
}

