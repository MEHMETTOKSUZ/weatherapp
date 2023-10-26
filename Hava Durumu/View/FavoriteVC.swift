//
//  ViewController.swift
//  Hava Durumu
//
//  Created by Mehmet ÖKSÜZ on 27.09.2023.
//

import UIKit

class FavoriteVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var searchButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    
    
   
    
    var viewModel = FavoriteViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.didFinishLoad = { [weak self] in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
        
        tableView.delegate = self
        tableView.dataSource = self
        viewModel.loadFavoriteCities()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        viewModel.loadFavoriteCities()
        
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfInSection
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "favoriteCell") as! FavoriteCell
        
        cell.selectionStyle = .none
        let cityViewModel = viewModel.getFavoriteCities(at: indexPath.row)
        cell.configure(city: cityViewModel)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let selectedCity = viewModel.getFavoriteCities(at: indexPath.row)
        performSegue(withIdentifier: "toSearchForDetails", sender: selectedCity)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toSearchForDetails" {
            if let destinationVC = segue.destination as? DetailsVC {
                if let indexPath = tableView.indexPathForSelectedRow {
                    let selectedCity = viewModel.getFavoriteCities(at: indexPath.row)
                    destinationVC.selectedCity = selectedCity
                }
            }
        }
    }
    
    @IBAction func searchButtonClicked(_ sender: Any) {
        
        performSegue(withIdentifier: "toSearchVC", sender: nil)
        
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            
            let cityToRemove = viewModel.favoriteCities[indexPath.row]
            FavoriteManager.shared.removeCityFromFavorites(city: cityToRemove.data)
            viewModel.favoriteCities.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
}

