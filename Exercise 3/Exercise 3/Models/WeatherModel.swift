//
//  WeatherModel.swift
//  Exercise 3
//
//  Created by Özgür  Atak  on 24.08.2023.
//



import Foundation

struct WeatherModel: Codable {
    var weather: [Weather]
    var main: Main
    var coord: Coord
    var wind: Wind
    var name: String?
}

struct Weather: Codable {
    var id: Int?
    var main: String?
    var description: String?
    var icon: String?
}

struct Main: Codable {
    var temp: Double?
    var feels_like: Double?
    var temp_min: Double?
    var temp_max: Double?
    var pressure: Int?
    var humidty: Int?
}

struct Coord: Codable {
    var lon: Double?
    var lat: Double?
}

struct Wind: Codable {
    var speed: Double?
    var deg: Int?
    var gust: Double?
}
