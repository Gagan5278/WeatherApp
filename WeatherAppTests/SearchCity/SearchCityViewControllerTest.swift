//
//  SearchCityViewControllerTest.swift
//  WeatherAppTests
//
//  Created by Gagan Vishal  on 2023/02/21.
//

import XCTest
import Combine
@testable import WeatherApp

final class SearchCityViewControllerTest: XCTestCase {
    
    private var sutSearchCityViewController: SearchCityViewController!
    private var mockSearchCityViewViewModel: SearchCityViewViewModel!
    private var mockService: MockSearchCityNetworkService!
    private var cancellable: AnyCancellable?
    private var mockNavigationController: MockNavigationController!
    
    override func setUp() {
        mockService = MockSearchCityNetworkService()
        mockSearchCityViewViewModel = SearchCityViewViewModel(request: mockService)
        sutSearchCityViewController = SearchCityViewController(viewModel: mockSearchCityViewViewModel)
        mockNavigationController = MockNavigationController(rootViewController: sutSearchCityViewController)
        sutSearchCityViewController.loadViewIfNeeded()
        sutSearchCityViewController.viewDidLoad()
    }
    
    override func tearDown() {
        sutSearchCityViewController = nil
        mockSearchCityViewViewModel = nil
        mockService = nil
    }
    
    func testSearchCityViewController_ViewLoaded_ViewShouldNotBeNil() {
        XCTAssertNotNil(sutSearchCityViewController.view)
    }
    
    func testSearchCityViewController_ViewLoaded_NavigationTitleShouldNotBeNil() {
        XCTAssertNotNil(sutSearchCityViewController.title)
    }
    
    func testSearchCityViewController_ViewHasBeenLoaded_ViewModelIsNotNil() {
        XCTAssertNotNil(sutSearchCityViewController.searchCityViewModel, "SearchCityViewModel is nil")
    }
    
    func testSearchCityViewController_ViewHasBeenLoaded_SearchBarDelegateIsNotNil() {
        XCTAssertNotNil(sutSearchCityViewController.searchCitySearchBar.delegate, "SearchCitySearchBar Delegate is nil")
    }
    
    func testSearchCityViewController_ViewHasBeenLoaded_ConfirmsUISearchBarDelegate() {
        XCTAssertTrue(sutSearchCityViewController.conforms(to: UISearchBarDelegate.self), "Does not confirm UISearchBarDelegate")
    }
    
    func testSearchCityViewController_ViewHasBeenLoaded_SearchCityTableViewDelegateIsNotNil() {
        XCTAssertNotNil(sutSearchCityViewController.searchCityTableView.delegate, "SearchTableView Delegate is nil")
    }
    
    func testSearchCityViewController_ViewHasBeenLoaded_ConfirmsUITableViewDelegate() {
        XCTAssertTrue(sutSearchCityViewController.conforms(to: UITableViewDelegate.self), "Does not confirm UITableViewDelegate")
    }
    
    func testSearchCityViewController_ViewHasBeenLoaded_SearchTableViewDataSourceIsNotNil() {
        XCTAssertNotNil(sutSearchCityViewController.searchCityTableView.dataSource, "UITableView data source is nil")
    }
    
    func testSearchCityViewController_ViewHasBeenLoaded_ConfirmsUITableViewDataSource() {
        XCTAssertTrue(sutSearchCityViewController.conforms(to: UITableViewDataSource.self), "Does not confirm UITableViewDataSource")
    }
    
    func testSearchCityViewController_ViewHasBeenLoaded_TableViewCellHasReuseIdentifier() {
        let expectation = self.expectation(description: "Search city for given valid text")
        
        mockSearchCityViewViewModel.performSearch(text: "rene")
        cancellable = mockSearchCityViewViewModel.requestOutput
            .sink { [weak self] output in
                let cell = self?.sutSearchCityViewController.tableView(
                    (self?.sutSearchCityViewController.searchCityTableView)!,
                    cellForRowAt: IndexPath(row: 0, section: 0)
                ) as? SearchWeatherCityTableViewCell
                XCTAssertNotNil(cell)
                let actualReuseIdentifer = cell?.reuseIdentifier
                XCTAssertNotNil(actualReuseIdentifer)
                let expectedReuseIdentifier = SearchWeatherCityTableViewCell.reuseIdentifier
                XCTAssertEqual(actualReuseIdentifer, expectedReuseIdentifier)
                expectation.fulfill()
            }
        self.wait(for: [expectation], timeout: 10)
    }
    
    func testSearchCityViewController_HasRightBarButtonItem_WithActionMethodCorrectlyAssigned() {
        if let rightBarButtonItem = sutSearchCityViewController.navigationItem.rightBarButtonItem {
            XCTAssertNotNil(rightBarButtonItem.action)
            XCTAssertTrue(rightBarButtonItem.action?.description == "saveButtonActionWithSender:")
        }
        else {
            XCTAssertTrue(false)
        }
    }
    
    func testSearchCityViewController_CanPushToSavedCitiesViewController_WhenRightBarButtonTapped() {
        RunLoop.main.run(until: Date() +  1 )
        XCTAssertTrue(mockNavigationController.pushViewControllerIsCalled)
        sutSearchCityViewController.saveButtonAction(sender: UIBarButtonItem())
    }
    
}
