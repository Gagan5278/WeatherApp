//
//  SavedCitiesWeatherViewController.swift
//  WeatherApp
//
//  Created by Gagan Vishal  on 2023/02/24.
//

import UIKit
import CoreData

class SavedCitiesWeatherViewController: UITableViewController {
    
    private var coreDataManager: CoreDataManagerProtocol!
    lazy var fetchResultController: NSFetchedResultsController<SavedCityEntity> = {
        let fetchRequest  = self.coreDataManager.savedCityFetchRequest
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "cityName", ascending: true)]
        var fetchController = NSFetchedResultsController(
            fetchRequest: fetchRequest,
            managedObjectContext: self.coreDataManager.viewContext,
            sectionNameKeyPath: nil,
            cacheName: nil
        )
        fetchController.delegate = self
        return fetchController
    }()
    
    // MARK: - View Controller life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = AppConstants.SavedCitylViewConstants.navigationTitleConstant
        tableView.separatorStyle = .none
        tableView.register(nib: SavedCityWeatherTableViewCell.self)
        performFetch()
    }

    convenience init(coreDataManager: CoreDataManagerProtocol) {
        self.init(style: .plain)
        self.coreDataManager = coreDataManager
    }
    
    private func performFetch() {
        do {
            _ = try self.fetchResultController.performFetch()
        } catch let error {
            print("error is : \(error.localizedDescription)")
        }
    }
    
    private func emptyStateViewMessage() {
        tableView.setEmptyState(
            with: AppConstants.SavedCitylViewConstants.emptyStateTitleConstant,
            message: AppConstants.SavedCitylViewConstants.emptyStateMessageConstant,
            image: Image.weatherImage
        )
    }
    
    // MARK: - Get total saved city count
    func getCountOfSavedItems(in section: Int) -> Int {
        if let sections = fetchResultController.sections {
            let sectoinsInfo = sections[section]
            let numberOfObjects = sectoinsInfo.numberOfObjects
            numberOfObjects > 0 ? tableView.resetBackgroundView() : emptyStateViewMessage()
            return numberOfObjects
        }
        return 0
    }
    
    // MARK: - Create UITableViewCell
    fileprivate func prepareCell(_ tableView: UITableView, _ indexPath: IndexPath) -> UITableViewCell {
        let cell: SavedCityWeatherTableViewCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
        cell.savedCityEntity = fetchResultController.object(at: indexPath)
        return cell
    }
}

// MARK: - UITableViewDataSource
extension SavedCitiesWeatherViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        getCountOfSavedItems(in: section)
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        prepareCell(tableView, indexPath)
    }
}

// MARK: - UITableViewDelegate
extension SavedCitiesWeatherViewController {
    override func numberOfSections(in tableView: UITableView) -> Int {
        fetchResultController.sections!.count
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        guard editingStyle == .delete else { return }
        let city = self.fetchResultController.object(at: indexPath)
        fetchResultController.managedObjectContext.delete(city)
    }
    
    override func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return UITableViewCell.EditingStyle.delete
    }
}

// MARK: - NSFetchedResultsControllerDelegate implementation
extension SavedCitiesWeatherViewController: NSFetchedResultsControllerDelegate {
    
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>){
        self.tableView.beginUpdates()
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        self.tableView.endUpdates()
    }
    
    func controller(
        _ controller: NSFetchedResultsController<NSFetchRequestResult>,
        didChange anObject: Any,
        at indexPath: IndexPath?,
        for type: NSFetchedResultsChangeType,
        newIndexPath: IndexPath?
    ) {
        switch type {
        case .delete:
            if let deletedIndexPath = indexPath {
                self.tableView.deleteRows(at: [deletedIndexPath], with: .fade)
                do {
                    try coreDataManager.viewContext.save()
                } catch {
                    print(error)
                }
            }
        default: break
        }
    }
}
