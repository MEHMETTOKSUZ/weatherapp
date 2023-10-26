//
//  SearchModel.swift
//  Hava Durumu
//
//  Created by Mehmet ÖKSÜZ on 27.09.2023.
//

import Foundation
import UIKit

class SearchViewModel {
    
    var didFinishLoad: (() -> Void)?
    var didFinishLoadWithError: ((String) -> Void)?
    var weatherDatas: [FavoriteCell.ViewModel] = []
    
    func fetchData(city: String) {
        
        guard let stringUrl = URL(string: "https://api.openweathermap.org/data/2.5/weather?q=\(city)&appid=\(LocaleKeys.API_ID)") else {
            print("Invalid URL")
            return
        }
        
        WebService().fetchMediaData(from: stringUrl) { (result: Result<WeatherData, Error>) in
            switch result {
            case .success(let data):
                self.presentWeatherData(result: data)
            case .failure(let error):
                self.didFinishLoadWithError?(error.localizedDescription)
            }
        }
    }
    
    func presentWeatherData(result: WeatherData) {
        let model = FavoriteCell.ViewModel(response: result)
        self.weatherDatas = [model]
        self.didFinishLoad?()
    }
    
}
