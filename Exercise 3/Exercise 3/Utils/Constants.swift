//
//  Constants.swift
//  Exercise 3
//
//  Created by Özgür  Atak  on 24.08.2023.
//

import Foundation

struct Constants {
    
    struct Urls {
        func urlGenerator(city: String) -> URL {
            let base: String = "https://api.openweathermap.org/data/2.5/weather?q="
            let apiKey: String = "&appid=c151fb13eca68b4fe5095a91772d6a21"
            let unit: String = "&units="
            
            return URL(string: base + city.escaped().lowercased() + apiKey + unit + SettingsViewModel().selectedUnit.rawValue)!
        }
    }
    
    struct UserDefaults {
        func addWeather(city: String) {
            
        }
        
        func deleteWeather(city: String) {
            
        }
        
        func setDegreeType(type: Units) {
            
        }
    }
    
}

enum Units: String, CaseIterable {
    case metric = "metric"
    case imperial = "imperial"
}

extension Units { //Enum'ımızın sahip olduğu case'lerin rawValue değerlerine bir display name verebilmek için bunu ekledik. yani Unit.displayName.metric seçildiğinde bize Celcius stringi dönmesi için.
    var displayName: String {
        get {
            switch(self) {
            case .metric:
                return "Celcius (C°)"
            case .imperial:
                return "Fahrenheit (F°)"
            }
            
        }
    }
}
