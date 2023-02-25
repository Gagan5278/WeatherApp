//
//  WeatherViewViewModel.swift
//  WeatherApp
//
//  Created by Gagan Vishal  on 2023/02/22.
//

import Foundation
import Combine

class SearchCityViewViewModel {
    
    public private(set) var requestOutput: CurrentValueSubject<RequestOutput, Never> = .init(.initialState)
    private var cancellables = Set<AnyCancellable>()
    private var networkRequest: NetworkServiceProtocol
    private var searchedCities: [SearchCityModel] = []
    private var numberOfCellsInLoadingState = 3
    public private(set) var isLoading: Bool = false
    
    // MARK: - init
    init(request: NetworkServiceProtocol) {
        networkRequest = request
    }
    
    func performSearch(text: String) {
        guard !text.isEmpty else {
            searchedCities.removeAll()
            requestOutput.send(.initialState)
            return
        }
        isLoading = true
        requestOutput.send(.startFetchingCities)
        networkRequest.callService(from: EndPoint.fecthWeatherFor(city: text), model: [SearchCityModel].self, decoder: JSONDecoder())
            .sink { [weak self] completion in
                switch completion {
                case .finished: break
                case .failure(let error):
                    print(error)
                    self?.requestOutput.send(.searchCityDidFail)
                }
            } receiveValue: { [weak self] searchReult in
                if let cities = searchReult {
                    self?.searchedCities = cities
                    self?.requestOutput.send(cities.isEmpty ? .searchCityDidSucceedWithEmptyList : .searchCityDidSucceed)
                } else {
                    self?.requestOutput.send(.searchCityDidFail)
                }
                self?.isLoading = false
            }
            .store(in: &cancellables)
    }
    
    var numberOfRowsInSearchCityTable: Int {
        isLoading ? numberOfCellsInLoadingState : searchedCities.count
    }
    
    func getSearchedCity(at indexPath: IndexPath) -> SearchCityModel {
        guard indexPath.row <= searchedCities.count, !searchedCities.isEmpty else {
            fatalError()
        }
        return searchedCities[indexPath.row]
    }
    
}

// MARK: - User Request Output
extension SearchCityViewViewModel {
    enum RequestOutput {
        case initialState
        case startFetchingCities
        case searchCityDidFail
        case searchCityDidSucceed
        case searchCityDidSucceedWithEmptyList
    }
}
