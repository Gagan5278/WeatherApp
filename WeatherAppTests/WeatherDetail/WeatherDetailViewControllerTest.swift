//
//  WeatherDetailViewControllerTest.swift
//  WeatherAppTests
//
//  Created by Gagan Vishal  on 2023/02/23.
//

import XCTest
@testable import WeatherApp

final class WeatherDetailViewControllerTest: XCTestCase {
    
    private var sutWeatherDetailViewController: WeatherDetailViewController!
    private var mockService: MockWeatherNetworkService!
    private var saveCityWeatherService: SaveCityWeatherService!
    private let cities: [SearchCityModel] = JSONLoader.load("searchcity.json")
    private var weatherDetailViewModel: WeatherDetailViewModel!
    
    override func setUp() {
        mockService = MockWeatherNetworkService()
        saveCityWeatherService = SaveCityWeatherService(manager: CoreDataStackInMemory())
        weatherDetailViewModel = WeatherDetailViewModel(
            request: mockService,
            city: cities.first!,
            offlineService: saveCityWeatherService
        )
        sutWeatherDetailViewController = WeatherDetailViewController(viewModel: weatherDetailViewModel)
        sutWeatherDetailViewController.loadViewIfNeeded()
        sutWeatherDetailViewController.viewDidLoad()
    }
    
    override func tearDown() {
        sutWeatherDetailViewController = nil
        weatherDetailViewModel = nil
        saveCityWeatherService = nil
        mockService = nil
    }
    
    func testWeatherDetailViewController_ViewLoaded_ViewShouldNotBeNil() {
        XCTAssertNotNil(sutWeatherDetailViewController.view)
    }
    
    func testWeatherDetailViewController_ViewLoaded_NavigationTitleShouldNotBeNil() {
        XCTAssertNotNil(sutWeatherDetailViewController.title)
    }
    
    func testWeatherDetailViewController_HasRightBarButtonItem() {
        XCTAssertNotNil(sutWeatherDetailViewController.navigationItem.rightBarButtonItem)
    }
    
    func testWeatherDetailViewController_HasRightBarButtonItem_WithTarget_CorrectlyAssigned() {
        if let rightBarButtonItem = sutWeatherDetailViewController.navigationItem.rightBarButtonItem {
            XCTAssertNotNil(rightBarButtonItem.target)
            XCTAssert(rightBarButtonItem.target === sutWeatherDetailViewController)
        }
        else {
            XCTAssertTrue(false)
        }
    }
    
    func testWeatherDetailViewController_HasRightBarButtonItem_WithActionMethodCorrectlyAssigned() {
        if let rightBarButtonItem = sutWeatherDetailViewController.navigationItem.rightBarButtonItem {
            XCTAssertNotNil(rightBarButtonItem.action)
            XCTAssertTrue(rightBarButtonItem.action?.description == "saveButtonActionWithSender:")
        }
        else {
            XCTAssertTrue(false)
        }
    }
}
