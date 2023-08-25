//
//  File.swift
//  Exercise 3
//
//  Created by Özgür  Atak  on 24.08.2023.
//

import Foundation

class WeatherListViewModel {
    
    private var weatherViewModels = [WeatherViewModel]()
    
    func addWeatherViewModel(_ vm: WeatherViewModel) {
        weatherViewModels.append(vm)
    }
    
    func numberOfRows(_ section: Int) -> Int {
        return weatherViewModels.count
    }
    
    func modelAt(_ index: Int) -> WeatherViewModel {
        return weatherViewModels[index]
    }
    
    func updateUnit(to unit: Units) {
        switch unit {
        case .metric:
            toCelcius()
        case .imperial:
            toFahrenheit()
        }
    }
    
    private func toCelcius() {
        weatherViewModels = weatherViewModels.map { vm in
            let weatherModel = vm
            weatherModel.temp = (weatherModel.temp - 32) * 5/9
            return weatherModel
        }
    }
    private func toFahrenheit() {
        weatherViewModels = weatherViewModels.map { vm in
            let weatherModel = vm
            weatherModel.temp = (weatherModel.temp * 9/5) + 32
            return weatherModel
        }
    }
}


class WeatherViewModel {
    
    let weather: WeatherModel
    var temp: Double
    
    init(weather: WeatherModel) {
        self.weather = weather
        temp = weather.main.temp!
    }
    
    var city: String {
        if let cityName = weather.name {
            return cityName
        }
        return weather.name!
    }
    
}
