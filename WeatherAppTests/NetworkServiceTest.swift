//
//  NetworkServiceTest.swift
//  WeatherAppTests
//
//  Created by Gagan Vishal  on 2023/02/23.
//

import XCTest
import Combine
@testable import WeatherApp

final class NetworkServiceTest: XCTestCase {
    
    private var sutNetworkService: NetworkServiceProtocol!
    private var cancellable: AnyCancellable?
    
    override func setUp() {
        sutNetworkService =  MockWeatherNetworkService()
    }
    
    override func tearDown() {
        sutNetworkService = nil
        cancellable?.cancel()
    }
    
    func testNetworkService_WhenValidImageURLGiven_RetrunNotNilImage()  {
        let expectation = self.expectation(description: "Get image from given url ")
        let endPointImage = EndPoint.downloadWeatherIcon(name: "04")
        cancellable = sutNetworkService.fetchWeatherIcon(from: endPointImage)
            .sink(receiveCompletion: { completion in },
                  receiveValue: { image in
                XCTAssertNotNil(image)
                expectation.fulfill()
            })
        self.wait(for: [expectation], timeout: 5)
    }
    
    
    func testNetworkService_WhenValidWeatherLatLonURLGiven_RetrunNotNilWeatherModel()  {
        let expectation = self.expectation(description: "Get Weather model from given lat lon ")
        let endPointWeather = EndPoint.fetchCurrentLocationWeather(lat: 123.12, lon: 123.23)
        cancellable = sutNetworkService.callService(
            from: endPointWeather,
            model: WeatherModel.self,
            decoder: JSONDecoder()
        )
        .sink { completion in }
    receiveValue: { weather in
        XCTAssertNotNil(weather)
        expectation.fulfill()
    }
        self.wait(for: [expectation], timeout: 5)
    }
}
