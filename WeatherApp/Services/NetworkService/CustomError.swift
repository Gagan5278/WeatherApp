//
//  CustomError.swift
//  WeatherApp
//
//  Created by Gagan Vishal  on 2023/02/22.
//

import Foundation

enum CustomError: Error {
    case invalidURL(url: String)
    case clientError
    case serviceError
    case errorCustom(Error)
    
    static func mapError(error: Error) -> CustomError {
        return (error as? CustomError) ??  errorCustom(error)
    }
}
