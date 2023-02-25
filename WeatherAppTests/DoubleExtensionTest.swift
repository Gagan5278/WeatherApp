//
//  DoubleExtensionTest.swift
//  WeatherAppTests
//
//  Created by Gagan Vishal  on 2023/02/25.
//

import XCTest
@testable import WeatherApp


final class DoubleExtensionTest: XCTestCase {
    
    override func setUp() { }
    
    override func tearDown() { }
    
    func testConvertTemperatureIntoKelvin_WhenTemperatureIsInKelvin_ShoundNotChangeAnyValue() {
        // Given
        TemperatureUnitManager.sharedInstance.currentTemperatureUnit = .kelvin
        let kelvinValue: Double = 500
        // When
        let returnedValue = Double(kelvinValue.getHumanReadableTemp(with: .kelvin).filter {$0.isWholeNumber})
        // Then
        XCTAssertNotNil(returnedValue)
        XCTAssertTrue(returnedValue == kelvinValue)
    }
    
    func testConvertTemperatureIntoCelsius_WhenTemperatureIsInKelvin_ShoundNotChangeAnyValue() {
        // Given
        TemperatureUnitManager.sharedInstance.currentTemperatureUnit = .kelvin
        let kelvinValue: Double = 500
        let differenceBetweenKelvinToCelsius = 273.15
        let expextedValue = kelvinValue - differenceBetweenKelvinToCelsius
        // When
        let returnedValue = Double(kelvinValue.getHumanReadableTemp(with: .celsius).trimmingCharacters(in: CharacterSet(charactersIn: "0123456789.").inverted))
        // Then
        XCTAssertNotNil(returnedValue)
        XCTAssertTrue(returnedValue?.rounded() == expextedValue.rounded())
    }
    
    func testConvertTemperatureIntoFahrenheit_WhenTemperatureIsInKelvin_ShoundNotChangeAnyValue() {
        // Given
        TemperatureUnitManager.sharedInstance.currentTemperatureUnit = .fahrenheit
        let kelvinValue: Double = 500
        let expextedValue = 1.8*(kelvinValue-273.15) + 32 // Formula to covert Kelvin to Fahrenheit
        // When
        let returnedValue = Double(kelvinValue.getHumanReadableTemp(with: .fahrenheit).trimmingCharacters(in: CharacterSet(charactersIn: "0123456789.").inverted))
        // Then
        XCTAssertNotNil(returnedValue)
        XCTAssertTrue(returnedValue?.rounded() == expextedValue.rounded())
    }
}
