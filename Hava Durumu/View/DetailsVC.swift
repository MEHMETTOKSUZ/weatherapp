//
//  DetailsVC.swift
//  Hava Durumu
//
//  Created by Mehmet ÖKSÜZ on 10.10.2023.
//

import UIKit
import MapKit

class DetailsVC: UIViewController , MKMapViewDelegate {
    
    
    @IBOutlet weak var visibilityVİew: UIView!
    @IBOutlet weak var visibilityLabel: UILabel!
    @IBOutlet weak var sunriseLabel: UILabel!
    @IBOutlet weak var sunsetLabel: UILabel!
    @IBOutlet weak var hoursView: UIView!
    @IBOutlet weak var weatherBackgroundView: UIView!
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var windSpeedLabel: UILabel!
    @IBOutlet weak var countryLabel: UILabel!
    @IBOutlet weak var cityNameLabel: UILabel!
    @IBOutlet weak var pressureLabel: UILabel!
    @IBOutlet weak var humunityLabel: UILabel!
    @IBOutlet weak var destinationLabel: UILabel!
    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var detailsDestinationImage: UIImageView!
    
    var selectedCity: FavoriteCell.ViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getLocationOnMap()
        getHuminityAndPressure()
        getDescription()
        getWindSpeed()
        getCityName()
        getCountryName()
        getSunriseAndSunrise()
        getVisibility()
        convertTemp()
        getLocationOnMap()
        weatherBackgroundView.backgroundColor = .systemBlue
        hoursView.backgroundColor = .systemBlue
        visibilityVİew.backgroundColor = .systemBlue
    }
    
    func getHuminityAndPressure() {
        self.humunityLabel.text = selectedCity?.humidity
        self.pressureLabel.text = selectedCity?.pressure
    }
    
    func getDescription() {
        if let image = UIImage(named: selectedCity?.weatherType.backgroundImage ?? "" ) {
            self.detailsDestinationImage.image = image
        } else {
            self.detailsDestinationImage.image = UIImage(named: "cloud")
        }
        
        self.destinationLabel.text = selectedCity?.description
    }
    
    func getWindSpeed() {
        windSpeedLabel.text = String("Speed: \(selectedCity?.speed ?? 0) m/s")

    }
    
    func getCountryName() {
        countryLabel.text = "Country: \(selectedCity?.country ?? "")"

    }
    
    func getCityName() {
        cityNameLabel.text = selectedCity?.name

    }
    
    func getSunriseAndSunrise() {
        
        let timestampSunrise = selectedCity?.sunrise ?? 0
        
        let sunriseDate = Date(timeIntervalSince1970: TimeInterval(timestampSunrise))
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        let sunriseTime = dateFormatter.string(from: sunriseDate)
        sunriseLabel.text = "Sunrise: \(sunriseTime)"
        let timestampSunset = selectedCity?.sunset ?? 0
        let sunsetDate = Date(timeIntervalSince1970: TimeInterval(timestampSunset))
        let sunsetTime = dateFormatter.string(from: sunsetDate)
        sunsetLabel.text = "Sunset: \(sunsetTime)"
    }
    
    func getVisibility() {
        
         let visibilityInKilometers = Double(selectedCity?.visibility ?? 0) / 1000.0
             visibilityLabel.text = String(format: "Visibility: %.2f km", visibilityInKilometers)
    }
    
    func convertTemp() {
        tempLabel.text = selectedCity?.temp
    }
    
    func getLocationOnMap() {
        
        let locationCoordinate = CLLocationCoordinate2D(latitude: selectedCity?.lat ?? 0, longitude: selectedCity?.lon ?? 0)
        
        let annotation = MKPointAnnotation()
        annotation.coordinate = locationCoordinate
        annotation.title = "Konum"
        mapView.addAnnotation(annotation)
        mapView.setCenter(locationCoordinate, animated: true)
        
    }
}
