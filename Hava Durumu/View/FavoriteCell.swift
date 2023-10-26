//
//  FavoriteCell.swift
//  Hava Durumu
//
//  Created by Mehmet ÖKSÜZ on 27.09.2023.
//

import UIKit

class FavoriteCell: UITableViewCell {
    
    struct ViewModel {
        let name: String
        let temp: String
        let description: String
        let id: Int
        let humidity: String
        let pressure: String
        let lat: Double
        let lon: Double
        let speed: Double
        let country: String
        let sunrise: Int         
        let sunset: Int
        let visibility: Int 
        let data: WeatherData
        let color: UIColor
    }
    
    @IBOutlet weak var pressureLabel: UILabel!
    @IBOutlet weak var humidityLabel: UILabel!
    @IBOutlet weak var descriptionBackground: UIView!
    @IBOutlet weak var descritpionBackgroundImage: UIImageView!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var cityNameLabel: UILabel!
    @IBOutlet weak var tempLabel: UILabel!
    
    func configure(city: ViewModel) {
        self.cityNameLabel.text = city.name
        self.tempLabel.text = city.temp
        self.humidityLabel.text = city.humidity
        self.pressureLabel.text = city.pressure
        
        if let image = UIImage(named: city.description ) {
            self.descritpionBackgroundImage.image = image
        } else {
            self.descritpionBackgroundImage.image = UIImage(named: "cloud")
        }
        
        self.descriptionLabel.text = city.description
        self.descriptionBackground.backgroundColor = city.color
    }

}

extension FavoriteCell.ViewModel {
    init(response: WeatherData) {
        
        let percentFormatter = NumberFormatter()
        percentFormatter.numberStyle = .percent
        percentFormatter.maximumFractionDigits = 0
        
        let humidity = "H \(percentFormatter.string(from: NSNumber(value: response.main.humidity / 100.0)) ?? "N/A")"
        
        let hPaFormatter = NumberFormatter()
        hPaFormatter.maximumFractionDigits = 0
        
        let pressure = "P \(hPaFormatter.string(from: NSNumber(value: response.main.pressure)) ?? "N/A") hPa"
        
        self.init(
            name: response.name.uppercased(),
            temp: TemperatureConverter.shared.convertTemperature(model: response.main),
            description: response.weather.map({$0.description}).first ?? "",
            id: response.id,
            humidity: humidity,
            pressure: pressure,
            lat: response.coord.lat,
            lon: response.coord.lon,
            speed: response.wind.speed,
            country: response.sys.country,
            sunrise: response.sys.sunrise,
            sunset: response.sys.sunset,
            visibility: response.visibility,
            data: response,
            color: TemperatureConverter.shared.temperatureColorForValue(temp: response.main.temp)
        )
    }
}
