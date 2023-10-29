//
//  FavoriteViewModel.swift
//  Hava Durumu
//
//  Created by Mehmet ÖKSÜZ on 1.10.2023.
//

import Foundation
import UIKit

class FavoriteViewModel {
    
    var favoriteCities: [FavoriteCell.ViewModel] = []
    var didFinishLoad: (() -> Void)?
    var didFinidhLoadWithError: ((String) -> Void)?
    
    var numberOfInSection: Int {
        return favoriteCities.count
    }
    
    func getFavoriteCities(at index: Int) -> FavoriteCell.ViewModel {
        return favoriteCities[index]
    }
    
    func loadFavoriteCities() {
        if let favoriteCitiesData = UserDefaults.standard.object(forKey: "FavoriteCities") as? Data {
            if let savedCities = try? JSONDecoder().decode([WeatherData].self, from: favoriteCitiesData) {
                self.presentFavorite(result: savedCities)
            } else {
                self.didFinidhLoadWithError?("Error")
            }
        }
    }
   
    func presentFavorite(result: [WeatherData]) {
        
        let viewModel: [FavoriteCell.ViewModel] = result.map { result in
            FavoriteCell.ViewModel(response: result)
        }
        
        self.favoriteCities = viewModel
        self.didFinishLoad?()
        
    }
}

