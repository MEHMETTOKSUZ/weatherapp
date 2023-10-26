//
//  AramaVC.swift
//  Hava Durumu
//
//  Created by Mehmet ÖKSÜZ on 27.09.2023.
//

import UIKit
import MapKit

class SearchVC: UIViewController, UISearchBarDelegate , MKMapViewDelegate{
    
    
    var searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        return searchBar
    }()
    
    
    @IBOutlet weak var destinationImageView: UIImageView!
    @IBOutlet weak var favoriteButtonOutlet: UIButton!
    @IBOutlet weak var destinationLabel: UILabel!
    @IBOutlet weak var cityNameLabel: UILabel!
    @IBOutlet weak var tempLabel: UILabel!
    
    let viewModel = SearchViewModel()    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        cityNameLabel.isHidden = true
        tempLabel.isHidden = true
        favoriteButtonOutlet.isHidden = true
        destinationLabel.isHidden = true
        
        view.addSubview(searchBar)
        
        searchBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        searchBar.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        searchBar.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        
        searchBar.delegate = self
        updateFavoriteButtonState()
        
        viewModel.didFinishLoad = {
            DispatchQueue.main.async {
                self.showData()
                
            }
        }
    }
    
    
    func showData() {
        
        if let data = self.viewModel.weatherDatas.first {
            self.cityNameLabel.text = data.name
            
            self.tempLabel.text = data.temp
            
            let lowercasedDescription = data.description.lowercased()
            
            if lowercasedDescription.contains("clear sky") {
                self.destinationImageView.image = UIImage(systemName: "sun.max")
                self.destinationLabel.text = "clear sky"
            } else if lowercasedDescription.contains("cloud") {
                self.destinationImageView.image = UIImage(systemName: "cloud")
                self.destinationLabel.text = "cloudy"
            } else if lowercasedDescription.contains("light rain") {
                self.destinationImageView.image = UIImage(systemName: "cloud.rain")
                self.destinationLabel.text = "light rain"
            } else {
                self.destinationImageView.image = nil
                self.destinationLabel.text = "Açıklama Yok"
            }
            
            self.cityNameLabel.isHidden = false
            self.tempLabel.isHidden = false
            self.favoriteButtonOutlet.isHidden = false
            self.destinationLabel.isHidden = false
            self.updateFavoriteButtonState()
        } else {
            
        }
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        guard let query = searchBar.text, !query.isEmpty else {
            return
        }
        
        viewModel.fetchData(city: query)
    }
    
    @IBAction func favoriteButtonClicked(_ sender: Any) {
        
        guard let selectedCityViewModel = viewModel.weatherDatas.first else {
            return
        }
        
        let selectedCityWeatherData = selectedCityViewModel.data
        
        if FavoriteManager.shared.isCityFavorite(city: selectedCityWeatherData) {
            FavoriteManager.shared.removeCityFromFavorites(city: selectedCityWeatherData)
        } else {
            FavoriteManager.shared.toggleCityFavoriteStatus(city: selectedCityWeatherData)
        }
        
        updateFavoriteButtonState()
        navigationController?.popViewController(animated: true)
    }
    
    func updateFavoriteButtonState() {
        guard let selectedCityViewModel = viewModel.weatherDatas.first else {
            return
        }
        
        let selectedCityWeatherData = selectedCityViewModel.data
        
        if FavoriteManager.shared.isCityFavorite(city: selectedCityWeatherData) {
            favoriteButtonOutlet.setImage(UIImage(systemName: "star.fill"), for: .normal)
        } else {
            favoriteButtonOutlet.setImage(UIImage(systemName: "star"), for: .normal)
        }
    }
}
