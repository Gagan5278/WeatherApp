//
//  SaveCityWeatherServiceTest.swift
//  WeatherAppTests
//
//  Created by Gagan Vishal  on 2023/02/23.
//

import XCTest
@testable import WeatherApp

final class SaveCityWeatherServiceTest: XCTestCase {
    
    private var sutSaveCityWeatherService: SaveCityWeatherService!
    private var coreDataStackInMemory: CoreDataManagerProtocol!
    
    override func setUp() {
        coreDataStackInMemory =  CoreDataStackInMemory()
        sutSaveCityWeatherService = SaveCityWeatherService(manager: coreDataStackInMemory)
    }
    
    override func tearDown() {
        sutSaveCityWeatherService = nil
        coreDataStackInMemory = nil
    }
    
    func testSaveCityWeatherService_WhenAWeatherModelAvailable_CoreDataStackShouldSave() {
        // Given
        let weatherModel: WeatherModel = JSONLoader.load("weather.json")
        let fetch = coreDataStackInMemory.savedCityFetchRequest
        let entitiesBefore = try! coreDataStackInMemory.viewContext.fetch(fetch)
        XCTAssertTrue(entitiesBefore.isEmpty)
        
        // When
        sutSaveCityWeatherService.saveWeatherFor(city: weatherModel)
        let entitiesAfter = try! coreDataStackInMemory.viewContext.fetch(fetch)
        
        // Then
        XCTAssertFalse(entitiesAfter.isEmpty, "Must be saved in core data")
    }
}
