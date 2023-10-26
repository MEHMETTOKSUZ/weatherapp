//
//  ConverTemp.swift
//  Hava Durumu
//
//  Created by Mehmet ÖKSÜZ on 5.10.2023.
//

import Foundation
import UIKit

class TemperatureConverter {
    
    static let shared = TemperatureConverter()
    
    var isCelsiusSelected: Bool {
        get {
            return UserDefaults.standard.bool(forKey: "temperatureUnit")
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "temperatureUnit")
        }
    }
    
    func convertTemperature(model: Main) -> String {
        if isCelsiusSelected {
            return "\(Int(model.celciusTemp)) °C"
        } else {
            return "\(Int(model.fahrenheitTemp)) F"
        }
    }
    
    func temperatureColorForValue(temp: Double) -> UIColor {
        
        let celsius = Double(temp - 273.15)
        
        if celsius < 20 {
            return UIColor.blue
        } else if celsius >= 20 && celsius <= 30 {
            return UIColor.yellow
        } else {
            return UIColor.red
        }
        
    }
}

