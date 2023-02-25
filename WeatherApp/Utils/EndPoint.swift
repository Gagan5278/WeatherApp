//
//  EndPoint.swift
//  WeatherApp
//
//  Created by Gagan Vishal  on 2023/02/22.
//

import Foundation

protocol EndPointProtocol {
    var requestURLString: String {get}
    var hostURLString: String {get}
}

extension EndPointProtocol {
    var hostURLString: String {
        guard let baseURL = Bundle.infoPlistValue(forKey: AppConstants.APIConstants.baseURLKeyInInfoPlist) as? String else {
            fatalError("Unable to find host url")
        }
        return baseURL
    }
}

enum EndPoint: EndPointProtocol {
    
    case downloadWeatherIcon(name: String)
    case fetchCurrentLocationWeather(lat: Double, lon: Double)
    case fecthWeatherFor(city: String)
    
    var requestURLString: String {
        createRquestURLString()
    }
    
    private var subPath: String {
        switch self {
        case .fecthWeatherFor:
            return "/geo/1.0/direct"
        case .fetchCurrentLocationWeather, .downloadWeatherIcon:
            return "/data/2.5/weather"
        }
    }
    
    private var openWeatherKey: String {
        guard let apiKey = Bundle.infoPlistValue(forKey: AppConstants.APIConstants.openWeatherAPITokenKeyInPlist) as? String else {
            fatalError("Unable to find API Key")
        }
        return apiKey
    }
    
    func createRquestURLString() -> String {
        var components = URLComponents()
        components.scheme = "https"
        switch self {
        case .downloadWeatherIcon(let name):
            components.host = "openweathermap.org"
            components.path.append("/img/wn/\(name)@2x.png")
        case .fetchCurrentLocationWeather(let latV, let lonV):
            components.host = hostURLString
            components.path = subPath
            components.queryItems = [
                URLQueryItem(name: "lat", value: "\(latV)"),
                URLQueryItem(name: "lon", value: "\(lonV)"),
                URLQueryItem(name: "appid", value: openWeatherKey)
            ]
        case .fecthWeatherFor(let searchText):
            components.host = hostURLString
            components.path = subPath
            components.queryItems = [
                URLQueryItem(name: "q", value: searchText),
                URLQueryItem(name: "limit", value: "6"),
                URLQueryItem(name: "appid", value: openWeatherKey)
            ]
        }
        return components.string ?? ""
    }
    
}
