//
//  SettingsVC.swift
//  Hava Durumu
//
//  Created by Mehmet ÖKSÜZ on 29.09.2023.
//

import UIKit
import MapKit

class SettingsVC: UIViewController, MKMapViewDelegate {
    
    @IBOutlet weak var tempValueSwitch: UISwitch!
        
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tempValueSwitch.isOn = TemperatureConverter.shared.isCelsiusSelected
    }
    
    @IBAction func tempSwitchClicked(_ sender: UISwitch) {
        
        TemperatureConverter.shared.isCelsiusSelected = sender.isOn
        
    }
}
