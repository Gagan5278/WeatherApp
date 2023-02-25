//
//  CoreDataManager.swift
//  WeatherApp
//
//  Created by Gagan Vishal  on 2023/02/24.
//

import Foundation
import CoreData

protocol CoreDataManagerProtocol {
    var savedCityEntityName: String { get }
    var viewContext: NSManagedObjectContext { get }
    var savedCityFetchRequest: NSFetchRequest<SavedCityEntity> { get }
}

class CoreDataManager: CoreDataManagerProtocol {
    
    private let persistantContainer: NSPersistentContainer
    private let persistantContainerName: String = "WeatherApp"
    private let entityName: String = "SavedCityEntity"
    private lazy var context: NSManagedObjectContext = {
        persistantContainer.viewContext
    }()
    
    // MARK: - init
    init() {
        persistantContainer = NSPersistentContainer(name: persistantContainerName)
        persistantContainer.loadPersistentStores { _, error in
            if let error = error {
                print(error.localizedDescription)
            }
        }
    }
    
    var savedCityEntityName: String {
        entityName
    }
    
    var viewContext: NSManagedObjectContext {
        context
    }
    
    var savedCityFetchRequest: NSFetchRequest<SavedCityEntity> {
        NSFetchRequest<SavedCityEntity>(entityName: savedCityEntityName)
    }
    
}
