//
//  AppCoordinator.swift
//  WeatherApp
//
//  Created by Gagan Vishal  on 2023/02/22.
//

import UIKit

protocol Coordinator {
    var navigationController: UINavigationController {get set}
    func start()
    func pushToWeatherScreen(with location: SearchCityModel)
    func pushToSavedOfflineCitiesWeatherList()
}

class AppCoordinator: Coordinator {
    
    var navigationController: UINavigationController
    
    // MARK: - init
    init(navigationContoller: UINavigationController) {
        self.navigationController = navigationContoller
    }
    
    func start() {
        let searchCityController = SearchCityViewController(
            viewModel: SearchCityViewViewModel(
                request: NetworkService()
            )
        )
        searchCityController.searchCityCoordinator = self
        searchCityController.view.backgroundColor = .appBackgroundColor
        navigationController.pushViewController(searchCityController, animated: true)
    }
    
    func pushToWeatherScreen(with location: SearchCityModel) {
        let weatherController = WeatherDetailViewController(viewModel: WeatherDetailViewModel(
            request: NetworkService(),
            city: location, offlineService: SaveCityWeatherService(manager: CoreDataManager()))
        )
        weatherController.view.backgroundColor = .appBackgroundColor
        navigationController.pushViewController(weatherController, animated: true)
    }
    
    func pushToSavedOfflineCitiesWeatherList() {
        let saveCityController = SavedCitiesWeatherViewController(coreDataManager: CoreDataManager())
        saveCityController.view.backgroundColor = .appBackgroundColor
        navigationController.pushViewController(saveCityController, animated: true)
    }

}
