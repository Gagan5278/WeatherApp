//
//  SavedCitiesWeatherViewControllerTest.swift
//  WeatherAppTests
//
//  Created by Gagan Vishal  on 2023/02/25.
//

import XCTest
import CoreData
@testable import WeatherApp

final class SavedCitiesWeatherViewControllerTest: XCTestCase {
    
    private var sutSavedCitiesWeatherViewController: SavedCitiesWeatherViewController!
    private var coreDataManager: CoreDataManagerProtocol!
    private var saveCityWeatherService: SaveCityWeatherService!
    private let weatherModel: WeatherModel = JSONLoader.load("weather.json")
    
    override func setUp() {
        coreDataManager =  CoreDataStackInMemory()
        saveCityWeatherService = SaveCityWeatherService(manager: coreDataManager)
        sutSavedCitiesWeatherViewController = SavedCitiesWeatherViewController(coreDataManager: coreDataManager)
        sutSavedCitiesWeatherViewController.loadViewIfNeeded()
        sutSavedCitiesWeatherViewController.viewDidLoad()
    }
    
    override func tearDown() {
        sutSavedCitiesWeatherViewController = nil
        coreDataManager = nil
        saveCityWeatherService = nil
    }
    
    func testSavedCitiesWeatherViewController_ViewLoaded_ViewShouldNotBeNil() {
        XCTAssertNotNil(sutSavedCitiesWeatherViewController.view)
    }
    
    func testSavedCitiesWeatherViewController_ViewLoaded_NavigationTitleShouldNotBeNil() {
        XCTAssertNotNil(sutSavedCitiesWeatherViewController.title)
    }
    
    func testSavedCitiesWeatherViewController_ViewHasBeenLoaded_SearchCityTableViewDelegateIsNotNil() {
        XCTAssertNotNil(sutSavedCitiesWeatherViewController.tableView.delegate, "SearchTableView Delegate is nil")
    }
    
    func testSavedCitiesWeatherViewController_ViewHasBeenLoaded_ConfirmsNSFetchedResultsControllerDelegate() {
        XCTAssertTrue(sutSavedCitiesWeatherViewController.conforms(to: NSFetchedResultsControllerDelegate.self), "Does not confirm NSFetchedResultsControllerDelegate")
    }
    
    func testSavedCitiesWeatherViewController_DataIsAvailable_NumberOfSectionMustBeGreaterThanZero() {
        saveCityWeatherService.saveWeatherFor(city: weatherModel)
        XCTAssertNotNil(sutSavedCitiesWeatherViewController.fetchResultController.sections)
        XCTAssertTrue(sutSavedCitiesWeatherViewController.fetchResultController.sections!.count > 0)
    }
    
    func testSavedCitiesWeatherViewController_DataIsAvailable_NumberOfRowsInASectionMustBeGreaterThanZero() {
        saveCityWeatherService.saveWeatherFor(city: weatherModel)
        XCTAssertNotNil(sutSavedCitiesWeatherViewController.fetchResultController.sections)
        XCTAssertTrue(sutSavedCitiesWeatherViewController.fetchResultController.sections!.count > 0)
        let rows = sutSavedCitiesWeatherViewController.getCountOfSavedItems(in: 0)
        XCTAssertTrue(rows > 0)
    }
    
}
