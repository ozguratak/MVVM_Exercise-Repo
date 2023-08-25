//
//  AddWeatherViewModel.swift
//  Exercise 3
//
//  Created by Özgür  Atak  on 24.08.2023.
//

import Foundation


class AddWeatherViewModel {
    
    func addWeather(for city: String, completion: @escaping (WeatherViewModel) -> Void) {
        let weatherResource = Resource<WeatherModel>(url: Constants.Urls().urlGenerator(city: city)) { data in
            let weatherResponse = try? JSONDecoder().decode(WeatherModel.self, from: data)
            return weatherResponse
        }
        
        Webservice().load(resource: weatherResource) { result in
            if let weatherResource = result {
                let vm = WeatherViewModel(weather: weatherResource)
                completion(vm)
            }
        }
    }    
    
}
