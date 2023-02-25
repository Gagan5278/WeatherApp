//
//  NetworkService.swift
//  WeatherApp
//
//  Created by Gagan Vishal  on 2023/02/22.
//

import UIKit
import Combine

protocol NetworkServiceProtocol {
    func fetchWeatherIcon(from endPoint: EndPointProtocol) -> AnyPublisher<UIImage?, Error>
    func callService<T: Codable>(from
                                 endPoint: EndPointProtocol,
                                 model: T.Type,
                                 decoder: JSONDecoder) -> AnyPublisher<T?, Error>
}

class NetworkService: NetworkServiceProtocol {
    
    // MARK: - Fetch Movie image from server
    func fetchWeatherIcon(from endPoint: EndPointProtocol) -> AnyPublisher<UIImage?, Error> {
        guard let url = URL(string: endPoint.requestURLString) else {
            return Fail(error: CustomError.invalidURL(url: endPoint.requestURLString))
                .eraseToAnyPublisher()
        }
        return NetworkingManager.download(from: url)
            .tryMap { (data) -> UIImage? in
                return UIImage(data: data)
            }
            .receive(on: RunLoop.main)
            .eraseToAnyPublisher()
    }
    
    // MARK: - Fetch a codable model from GET service
    func callService<T: Codable>(from
                                 endPoint: EndPointProtocol,
                                 model: T.Type,
                                 decoder: JSONDecoder) -> AnyPublisher<T?, Error> where T: Codable {
        guard let url = URL(string: endPoint.requestURLString) else {
            return Fail(error: CustomError.invalidURL(url: endPoint.requestURLString))
                .eraseToAnyPublisher()
        }
        return NetworkingManager.download(from: url)
            .map { data -> AnyPublisher<T?, Error> in
                if data.isEmpty {
                    return Just((true as? T) ?? nil)
                        .setFailureType(to: Error.self)
                        .eraseToAnyPublisher()
                }
                return Just(data)
                    .decode(type: T?.self, decoder: decoder)
                    .eraseToAnyPublisher()
            }
            .switchToLatest()
            .mapError { CustomError.mapError(error: $0) }
            .receive(on: RunLoop.main)
            .eraseToAnyPublisher()
    }
    
}
