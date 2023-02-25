//
//  NetworkingManager.swift
//  WeatherApp
//
//  Created by Gagan Vishal  on 2023/02/22.
//

import Foundation
import Combine

class NetworkingManager {
    
    static func download(from url: URL) -> AnyPublisher<Data, Error> {
        URLSession.shared.dataTaskPublisher(for: url)
            .tryMap { try handleResponse(output: $0, url: url)}
            .eraseToAnyPublisher()
    }
    
    private static func handleResponse(output: URLSession.DataTaskPublisher.Output, url: URL) throws -> Data {
        guard let response = output.response as? HTTPURLResponse, 200..<300 ~= response.statusCode else {
            throw CustomError.serviceError
        }
        return output.data
    }
    
}
