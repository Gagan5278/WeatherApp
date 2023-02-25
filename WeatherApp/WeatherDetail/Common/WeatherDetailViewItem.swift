//
//  WeatherDetailViewItem.swift
//  WeatherApp
//
//  Created by Gagan Vishal  on 2023/02/23.
//

import Foundation

struct WeatherDetailViewItem {
    
    var currentTemperatureInUnit: String {
        weatherModel.main.temp.getHumanReadableTemp(with: TemperatureUnitManager.sharedInstance.currentTemperatureUnit)
    }
    
    var feelsLikeTemperatureInUnit: String {
        "Feels like: " +  weatherModel.main.feelsLike.getHumanReadableTemp(with: TemperatureUnitManager.sharedInstance.currentTemperatureUnit)
    }
    
    var weatherDescription: String {
        guard let object = weatherModel.weather.first else {return ""}
        return object.weatherDescription.capitalized
    }
    
    var weatherIcon: EndPoint {
        guard let weatherIconName = weatherModel.weather.first?.icon else {
            return EndPoint.downloadWeatherIcon(name: "04n")
        }
        return EndPoint.downloadWeatherIcon(name: weatherIconName)
    }
    
    var locationName: String {
        weatherModel.name.appendWhiteSpaceAtEndAfter(adding: ",") + weatherModel.sys.country
    }
    
    var cityID: Int {
        weatherModel.id
    }
    
    private let weatherModel: WeatherModel
    // MARK: - init
    init(weatherModel: WeatherModel) {
        self.weatherModel = weatherModel
    }
    
}
