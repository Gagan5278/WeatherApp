//
//  SearchCityModel.swift
//  WeatherApp
//
//  Created by Gagan Vishal  on 2023/02/23.
//

import Foundation

struct SearchCityModel: Codable {
    let name: String?
    let lat: Double?
    let lon: Double?
    let country: String?
    let state: String?
}
