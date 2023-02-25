//
//  TemperatureUnitManager.swift
//  WeatherApp
//
//  Created by Gagan Vishal  on 2023/02/25.
//

import Foundation

class TemperatureUnitManager {
    
    static let sharedInstance = TemperatureUnitManager()
    
    var currentTemperatureUnit: TemperatureUnit = .kelvin
}
