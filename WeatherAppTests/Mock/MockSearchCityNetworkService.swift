//
//  MockSearchCityNetworkService.swift
//  WeatherAppTests
//
//  Created by Gagan Vishal  on 2023/02/21.
//

import UIKit
import Combine
@testable import WeatherApp

class MockSearchCityNetworkService: NetworkServiceProtocol {
    
    let searchCities: [SearchCityModel] = JSONLoader.load("searchcity.json")
    var isInvalidTextSearchedPerformed: Bool = false
    var shouldReturnAnError: Bool = false
    
    func fetchWeatherIcon(from endPoint: WeatherApp.EndPointProtocol) -> AnyPublisher<UIImage?, Error> {
        Just(UIImage())
            .tryMap({$0})
            .eraseToAnyPublisher()
    }
    
    func callService<T>(from endPoint: WeatherApp.EndPointProtocol, model: T.Type, decoder: JSONDecoder) -> AnyPublisher<T?, Error> where T : Decodable, T : Encodable {
        if shouldReturnAnError {
            return Fail(error: CustomError.serviceError)
                .eraseToAnyPublisher()
        }
        
        if isInvalidTextSearchedPerformed {
            return Just([])
                .tryMap({$0 as? T})
                .eraseToAnyPublisher()
        } else {
            return Just(searchCities)
                .tryMap({$0 as? T})
                .eraseToAnyPublisher()
        }
    }
    
}
