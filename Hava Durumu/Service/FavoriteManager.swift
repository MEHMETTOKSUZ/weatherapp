//
//  FavoriteManager.swift
//  Hava Durumu
//
//  Created by Mehmet ÖKSÜZ on 28.09.2023.
//


import Foundation

class FavoriteManager {
    
    static let shared = FavoriteManager()
    private let userDefaults = UserDefaults.standard
    private let favoritesKey = "FavoriteCities"
    
    var favoriteCities: [WeatherData] = []
    
    init() {
        if let data = userDefaults.data(forKey: favoritesKey),
           let favorites = try? JSONDecoder().decode([WeatherData].self, from: data) {
            favoriteCities = favorites
        }
    }
    
    func toggleCityFavoriteStatus(city: WeatherData) {
        
        if let index = favoriteCities.firstIndex(where: { $0.id == city.id }) {
            favoriteCities.remove(at: index)
        } else {
            favoriteCities.append(city)
        }
        saveFavoriteCities()
    }
    
    func getFavoriteCities() -> [WeatherData] {
        return favoriteCities
    }
    
    func isCityFavorite(city: WeatherData) -> Bool {
        return favoriteCities.contains(where: { $0.id == city.id })
    }
    
    func removeCityFromFavorites(city: WeatherData) {
        if let index = favoriteCities.firstIndex(where: { $0.id == city.id }) {
            favoriteCities.remove(at: index)
            saveFavoriteCities()
        }
    }
    
    private func saveFavoriteCities() {
        if let encodedData = try? JSONEncoder().encode(favoriteCities) {
            userDefaults.set(encodedData, forKey: favoritesKey)
        }
    }
}

