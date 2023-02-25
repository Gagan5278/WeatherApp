//
//  BundleExtensionTest.swift
//  WeatherAppTests
//
//  Created by Gagan Vishal  on 2023/02/22.
//

import XCTest
@testable import WeatherApp

final class BundleExtensionTest: XCTestCase {
    
    override func setUp() { }
    
    override func tearDown() { }
    
    func testOpenWeatherAPITokenKeyInPlistIsNotNil() {
        XCTAssertNotNil( Bundle.infoPlistValue(forKey: AppConstants.APIConstants.openWeatherAPITokenKeyInPlist))
    }
    
    func testOpenWeatherBaseURLKeyInInfoPlistInPlistIsNotNil() {
        XCTAssertNotNil( Bundle.infoPlistValue(forKey: AppConstants.APIConstants.baseURLKeyInInfoPlist))
    }
    
}
