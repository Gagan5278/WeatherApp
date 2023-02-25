//
//  SavedPostService.swift
//  WeatherApp
//
//  Created by Gagan Vishal  on 2023/02/24.
//

import Foundation
import CoreData

class SaveCityWeatherService {
    
    private let coreDataManager: CoreDataManagerProtocol
    
    // MARK: init
    init(manager: CoreDataManagerProtocol) {
        coreDataManager = manager
    }
}

// MARK: - Public Section
extension SaveCityWeatherService {
    
    func saveWeatherFor(city model: WeatherModel) {
        let fetchRequest = coreDataManager.savedCityFetchRequest
        fetchRequest.predicate = NSPredicate(format: "cityID = %d", model.id)
        let lastSavedEntity = try? coreDataManager.viewContext.fetch(fetchRequest).first
        if let savedEntity = lastSavedEntity {
            update(entity: savedEntity, with: model)
        } else {
            add(model: model)
        }
    }
    
}

// MARK: - Private Section
extension SaveCityWeatherService {
    
    // MARK: - Add city into Saved Entity
    private func add(model: WeatherModel) {
        let entity = SavedCityEntity(context: coreDataManager.viewContext)
        entity.cityName = model.name
        entity.countryName = model.sys.country
        entity.currentTemperature = model.main.temp
        entity.feelsLike = model.main.feelsLike
        entity.cityID =  Int32(model.id)
        entity.weatherDescription = model.weather.first?.weatherDescription ?? ""
        if let iconName = model.weather.first?.icon {
            entity.iconName = iconName
            if let cachedImage = ImageCache.getImage(for: EndPoint.downloadWeatherIcon(name: iconName).requestURLString as NSString) {
                entity.icon = cachedImage.pngData()
            }
        }
        saveEntity()
    }
    
    // MARK: - Update City weather
    private func update(entity: SavedCityEntity, with model: WeatherModel) {
        entity.cityName = model.name
        entity.countryName = model.sys.country
        entity.currentTemperature = model.main.temp
        entity.feelsLike = model.main.feelsLike
        entity.weatherDescription = model.weather.first?.weatherDescription ?? ""
        if let iconName = model.weather.first?.icon {
            entity.iconName = iconName
            if let cachedImage = ImageCache.getImage(for: EndPoint.downloadWeatherIcon(name: iconName).requestURLString as NSString) {
                entity.icon = cachedImage.pngData()
            }
        }
        saveEntity()
    }
    
    // MARK: - Save entity
    private func saveEntity() {
        do {
            try coreDataManager.viewContext.save()
        } catch let error {
            print("Error in saving city data with error: \(error.localizedDescription)")
        }
    }
    
}
