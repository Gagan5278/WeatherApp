//
//  CoreDataStackInMemory.swift
//  WeatherAppTests
//
//  Created by Gagan Vishal  on 2023/02/24.
//

import Foundation
import CoreData
@testable import WeatherApp

class CoreDataStackInMemory: CoreDataManagerProtocol  {
    
    var savedCityEntityName: String {
        "SavedCityEntity"
    }
    var savedCityFetchRequest: NSFetchRequest<WeatherApp.SavedCityEntity> {
        NSFetchRequest<SavedCityEntity>(entityName: savedCityEntityName)
    }
    var viewContext: NSManagedObjectContext {
        persistantContainer.viewContext
    }
    private let persistantContainer: NSPersistentContainer
    
    // MARK: - init
    init() {
        persistantContainer = {
            let container = NSPersistentContainer(name: "WeatherApp")
            let persistentDecsription = NSPersistentStoreDescription()
            // Set memory type
            persistentDecsription.type = NSInMemoryStoreType
            container.persistentStoreDescriptions = [persistentDecsription]
            container.loadPersistentStores {(_, error) in
                if let error = error {
                    fatalError("Something went wrong \(error.localizedDescription)")
                }
            }
            return container
        }()
    }
    
    private lazy var context: NSManagedObjectContext = {
        return persistantContainer.viewContext
    }()
    
}
