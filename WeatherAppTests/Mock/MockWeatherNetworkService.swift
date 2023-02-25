//
//  MockNetworkService.swift
//  WeatherAppTests
//
//  Created by Gagan Vishal  on 2023/02/21.
//

import UIKit
import Combine
@testable import WeatherApp

class MockWeatherNetworkService: NetworkServiceProtocol {
    
    private let weatherModel: WeatherModel = JSONLoader.load("weather.json")
    var isInvalidWeatherRequestPerformed: Bool = false
    var shouldReturnAnError: Bool = false
    
    func fetchWeatherIcon(from endPoint: WeatherApp.EndPointProtocol) -> AnyPublisher<UIImage?, Error> {
        Just(UIImage())
            .tryMap({$0})
            .eraseToAnyPublisher()
    }
    
    func callService<T: Codable>(from endPoint: WeatherApp.EndPointProtocol, model: T.Type, decoder: JSONDecoder) -> AnyPublisher<T?, Error> where T: Codable {
        
        if shouldReturnAnError {
            return Fail(error: CustomError.serviceError)
                .eraseToAnyPublisher()
        }
        
        if isInvalidWeatherRequestPerformed {
            return Just([])
                .tryMap({$0 as? T})
                .eraseToAnyPublisher()
        } else {
            return Just(weatherModel)
                .tryMap({$0 as? T})
                .eraseToAnyPublisher()
        }
    }
    
}
