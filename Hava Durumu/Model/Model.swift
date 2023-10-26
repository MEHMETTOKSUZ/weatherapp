//
//  Model.swift
//  Hava Durumu
//
//  Created by Mehmet ÖKSÜZ on 27.09.2023.
//


import Foundation

struct WeatherData: Codable {
    let main: Main
    let weather: [Weather]
    let id: Int
    let name: String
    let visibility: Int
    let coord: Coord
    let wind: Wind
    let sys: Sys
    
}

struct Main: Codable {
    let temp: Double
    let humidity: Double
    let pressure: Double
    
    var celciusTemp: Double {
        return temp - 273.15
    }
    
    var fahrenheitTemp: Double {
        return 1.8 * (temp - 273) + 32
    }
}

struct Weather: Codable {
    let description: String
    let icon: String             
    
}

struct Coord: Codable {
    let lon: Double
    let lat: Double
}

struct Wind: Codable {
    let speed: Double
    let deg: Int
}

struct Sys: Codable {
    let type: Int
    let id: Int
    let country: String
    let sunrise: Int
    let sunset: Int
}






