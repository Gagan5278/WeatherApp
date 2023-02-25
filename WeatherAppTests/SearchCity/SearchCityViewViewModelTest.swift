//
//  SearchCityViewViewModelTest.swift
//  WeatherAppTests
//
//  Created by Gagan Vishal  on 2023/02/21.
//

import XCTest
import Combine
@testable import WeatherApp

final class SearchCityViewViewModelTest: XCTestCase {
    
    private var sutSearchCityViewViewModel: SearchCityViewViewModel!
    private var mockService: MockSearchCityNetworkService!
    private var cancellable: AnyCancellable?
    
    override func setUp() {
        mockService = MockSearchCityNetworkService()
        sutSearchCityViewViewModel = SearchCityViewViewModel(request: mockService)
    }
    
    override func tearDown() {
        sutSearchCityViewViewModel = nil
        mockService = nil
    }
    
    func testSearchCityViewViewModel_WhenValidSearchTextGiven_ReturnSearchCityDidSucceed() {
        let expectation = self.expectation(description: "Search city for given text")
        // Given
        let searchText = "Stuttgart"
        XCTAssertTrue(!sutSearchCityViewViewModel.isLoading)
        // When
        sutSearchCityViewViewModel.performSearch(text: searchText)
        cancellable = sutSearchCityViewViewModel.requestOutput
            .sink { output in
                // Then
                XCTAssertTrue(output == .searchCityDidSucceed)
                expectation.fulfill()
            }
        self.wait(for: [expectation], timeout: 10)
    }
    
    func testSearchCityViewViewModel_WhenWorngValidSearchTextGiven_ReturnSearchCityDidSucceedWithEmptyList() {
        let expectation = self.expectation(description: "Search city for given Invalid text")
        // Given
        let searchText = "!{}*6*5623#$$#$%"
        mockService.isInvalidTextSearchedPerformed = true
        XCTAssertTrue(!sutSearchCityViewViewModel.isLoading)
        // When
        sutSearchCityViewViewModel.performSearch(text: searchText)
        cancellable = sutSearchCityViewViewModel.requestOutput
            .sink { output in
                // Then
                XCTAssertTrue(output == .searchCityDidSucceedWithEmptyList)
                expectation.fulfill()
            }
        self.wait(for: [expectation], timeout: 10)
    }
    
    func testSearchCityViewViewModel_WhenWorngValidSearchTextGiven_ReturnSearchCityDidFail() {
        let expectation = self.expectation(description: "Search city for given Invalid text")
        // Given
        let searchText = "Berlin"
        mockService.shouldReturnAnError = true
        XCTAssertTrue(!sutSearchCityViewViewModel.isLoading)
        // When
        sutSearchCityViewViewModel.performSearch(text: searchText)
        cancellable = sutSearchCityViewViewModel.requestOutput
            .sink { output in
                // Then
                XCTAssertTrue(output == .searchCityDidFail)
                expectation.fulfill()
            }
        self.wait(for: [expectation], timeout: 10)
    }
    
    func testSearchCityViewViewModel_WhenValidSearchTextGiven_ReturnNumberOfRowsIsGreaterThanZero() {
        let expectation = self.expectation(description: "Search city for given text, number of rows is greater than zero")
        // Given
        let searchText = "Reva"
        XCTAssertTrue(!sutSearchCityViewViewModel.isLoading)
        // When
        sutSearchCityViewViewModel.performSearch(text: searchText)
        cancellable = sutSearchCityViewViewModel.requestOutput
            .sink { [weak self] output in
                // Then
                XCTAssertTrue((self?.sutSearchCityViewViewModel.numberOfRowsInSearchCityTable)! > 0)
                XCTAssertTrue(output == .searchCityDidSucceed)
                expectation.fulfill()
            }
        self.wait(for: [expectation], timeout: 10)
    }
    
}
