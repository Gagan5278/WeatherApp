//
//  EndPointTest.swift
//  WeatherAppTests
//
//  Created by Gagan Vishal  on 2023/02/24.
//

import XCTest
@testable import WeatherApp

final class EndPointTest: XCTestCase {
    
    override func setUp() { }
    
    override func tearDown() { }
    
    func testEndPoint_WhenIconNameAavilable_downloadWeatherIconIsValidURLIsNotNil() {
        // Given
        let requestURLString =  EndPoint.downloadWeatherIcon(name: "0d").requestURLString
        // When
        let iconUrl = URL(string: requestURLString)
        // Then
        XCTAssertNotNil(iconUrl)
    }
    
    func testEndPoint_WhenLatAndLonAavilable_fetchWeatherRetutnURLIsNotNil() {
        // Given
        let requestURLString =  EndPoint.fetchCurrentLocationWeather(lat: 123.12, lon: 1223.1234).requestURLString
        // When
        let fetchWeatherUrl = URL(string: requestURLString)
        // Then
        XCTAssertNotNil(fetchWeatherUrl)
    }
    
    func testEndPoint_WhenSearchCityNameAavilable_fetchCitiesRetutnURLIsNotNil() {
        // Given
        let requestURLString =  EndPoint.fecthWeatherFor(city: "abc").requestURLString
        // When
        let citySearchUrl = URL(string: requestURLString)
        // Then
        XCTAssertNotNil(citySearchUrl)
    }
}
