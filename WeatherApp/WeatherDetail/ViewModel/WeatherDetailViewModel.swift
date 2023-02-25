//
//  WeatherDetailViewModel.swift
//  WeatherApp
//
//  Created by Gagan Vishal  on 2023/02/23.
//

import Foundation
import Combine

class WeatherDetailViewModel {
    
    public private(set) var weatherRequestOutput: CurrentValueSubject<WeatherRequestOutput, Never> = .init(.initialState)
    private let networkRequest: NetworkServiceProtocol
    private let selectedCity: SearchCityModel
    private var cancellables = Set<AnyCancellable>()
    private var saveCityWeatherService: SaveCityWeatherService!
    private var weatherRawModel: WeatherModel!
    
    // MARK: - init
    init(request: NetworkServiceProtocol, city: SearchCityModel, offlineService:  SaveCityWeatherService) {
        networkRequest = request
        selectedCity = city
        saveCityWeatherService = offlineService
    }
    
    func loadWeatherDetail() {
        if let latitude = selectedCity.lat, let longitude = selectedCity.lon {
            networkRequest.callService(
                from: EndPoint.fetchCurrentLocationWeather(lat: latitude, lon: longitude),
                model: WeatherModel.self,
                decoder: JSONDecoder()
            )
            .sink { [weak self] completion in
                switch completion {
                case .failure(let error):
                    print(error)
                    self?.weatherRequestOutput.send(.fetchWeatherDidFail)
                case .finished: break
                }
                
            } receiveValue: { [weak self] weatherRecieved in
                if let weather = weatherRecieved {
                    self?.weatherRawModel = weather
                    let weatherDetail = WeatherDetailViewItem(weatherModel: weather)
                    self?.weatherRequestOutput.send(.fetchWeatherDidSucceed(weather: weatherDetail))
                } else {
                    self?.weatherRequestOutput.send(.fetchWeatherDidSucceedWithEmptyData)
                }
            }
            .store(in: &cancellables)
        }
    }
    
    func saveSelectedCityForOfflineAccess() {
        if let weatherRawModel = weatherRawModel  {
            saveCityWeatherService.saveWeatherFor(city: weatherRawModel)
        }
    }
    
}

// MARK: - Weather Request Output
extension WeatherDetailViewModel {
    
    enum WeatherRequestOutput: Equatable {
        case initialState
        case fetchWeatherDidFail
        case fetchWeatherDidSucceed(weather: WeatherDetailViewItem)
        case fetchWeatherDidSucceedWithEmptyData
        
        static func == (lhs: WeatherRequestOutput, rhs: WeatherRequestOutput) -> Bool {
            lhs.value == rhs.value
        }
        
        var value: String? {
            return String(describing: self).components(separatedBy: "(").first
        }
    }
}
