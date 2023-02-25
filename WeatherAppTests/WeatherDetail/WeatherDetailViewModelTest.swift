//
//  WeatherDetailViewModelTest.swift
//  WeatherAppTests
//
//  Created by Gagan Vishal  on 2023/02/23.
//

import XCTest
import Combine
@testable import WeatherApp

final class WeatherDetailViewModelTest: XCTestCase {
    
    private var sutWeatherDetailViewModel: WeatherDetailViewModel!
    private var mockService: MockWeatherNetworkService!
    private var saveCityWeatherService: SaveCityWeatherService!
    private let cities: [SearchCityModel] = JSONLoader.load("searchcity.json")
    private var cancellable: AnyCancellable?
    
    override func setUp() {
        mockService = MockWeatherNetworkService()
        saveCityWeatherService = SaveCityWeatherService(manager: CoreDataStackInMemory())
        sutWeatherDetailViewModel = WeatherDetailViewModel(request: mockService, city: cities.first!, offlineService: saveCityWeatherService)
    }
    
    override func tearDown() {
        sutWeatherDetailViewModel = nil
        saveCityWeatherService = nil
        mockService = nil
    }
    
    
    func testWeatherDetailViewModel_WhenValidLatLonAvailable_ShouldReturnFetchWeatherDidSucceed() {
        let expectation = self.expectation(description: "Search weather for given lat lon")
        let weather: WeatherModel = JSONLoader.load("weather.json")
        sutWeatherDetailViewModel.loadWeatherDetail()
        cancellable = sutWeatherDetailViewModel.weatherRequestOutput
            .sink { output in
                XCTAssertTrue(output == .fetchWeatherDidSucceed(weather: WeatherDetailViewItem(weatherModel: weather)))
                expectation.fulfill()
            }
        self.wait(for: [expectation], timeout: 10)
    }
    
    func testWeatherDetailViewModel_WhenValidLatLonAvailable_ShouldReturnFetchWeatherDidSucceedWithEmptyData() {
        let expectation = self.expectation(description: "Search weather for given invalid lat lon")
        mockService.isInvalidWeatherRequestPerformed = true
        sutWeatherDetailViewModel.loadWeatherDetail()
        cancellable = sutWeatherDetailViewModel.weatherRequestOutput
            .sink { output in
                XCTAssertTrue(output == .fetchWeatherDidSucceedWithEmptyData)
                expectation.fulfill()
            }
        self.wait(for: [expectation], timeout: 10)
    }
    
    func testWeatherDetailViewModel_WhenValidLatLonAvailable_ShouldReturnFetchWeatherDidFail() {
        let expectation = self.expectation(description: "Search weather for given lat lon should fail")
        mockService.shouldReturnAnError = true
        sutWeatherDetailViewModel.loadWeatherDetail()
        cancellable = sutWeatherDetailViewModel.weatherRequestOutput
            .sink { output in
                XCTAssertTrue(output == .fetchWeatherDidFail)
                expectation.fulfill()
            }
        self.wait(for: [expectation], timeout: 10)
    }
    
}
