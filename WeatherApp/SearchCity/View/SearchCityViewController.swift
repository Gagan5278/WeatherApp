//
//  ViewController.swift
//  WeatherApp
//
//  Created by Gagan Vishal  on 2023/02/21.
//

import UIKit
import Combine

class SearchCityViewController: UIViewController {
    
    var searchCityCoordinator: Coordinator?
    private var searchCityOutputSubscribers = Set<AnyCancellable>()
    public private(set) var searchCityViewModel: SearchCityViewViewModel!
    
    lazy var searchCitySearchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.delegate = self
        searchBar.backgroundImage = UIImage()
        searchBar.isTranslucent = false
        searchBar.placeholder = AppConstants.SearchCityViewConstants.searchBarPlaceholderConstant
        return searchBar
    }()
    
    lazy var searchCityTableView: UITableView = {
        let tblView = UITableView()
        tblView.dataSource = self
        tblView.delegate = self
        tblView.register(nib: SearchWeatherCityTableViewCell.self)
        return tblView
    }()
    
    private var temperatureUnitRightBarButton: UIBarButtonItem!
    
    // MARK: - View Controller life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = AppConstants.SearchCityViewConstants.navigationTitleConstant
        addSubViewsOnViewAndSetupConstraints()
        bindViewModel()
        changeTemperatureUnitMenuLeftBarItem()
        saveForOfflineAccessRightBarButton()
        initialEmptyStateViewMessage()
    }
    
    convenience init(viewModel: SearchCityViewViewModel) {
        self.init(nibName: nil, bundle: nil)
        searchCityViewModel = viewModel
    }
    
    // MARK: - Bind View Model
    private func bindViewModel() {
        searchCityViewModel.requestOutput
            .receive(on: DispatchQueue.main)
            .sink { [weak self] event in
                guard let self = self else {return}
                switch event {
                case .searchCityDidSucceed:
                    self.searchCityTableView.resetBackgroundView()
                    self.reloadSearchedCityTableView()
                case .searchCityDidSucceedWithEmptyList:
                    self.reloadSearchedCityTableView()
                    self.noResultFoundEmptyStateViewMessage()
                case .searchCityDidFail:
                    self.reloadSearchedCityTableView()
                    self.noResultFoundEmptyStateViewMessage()
                case .startFetchingCities:
                    self.reloadSearchedCityTableView()
                case .initialState:
                    self.reloadSearchedCityTableView()
                    self.initialEmptyStateViewMessage()
                }
            }.store(in: &searchCityOutputSubscribers)
    }
    
    private func addSubViewsOnViewAndSetupConstraints() {
        view.addSubviews(searchCitySearchBar, searchCityTableView)
        
        searchCitySearchBar.anchor(
            top: self.view.safeAreaLayoutGuide.topAnchor,
            leading: self.view.leadingAnchor,
            bottom: nil,
            trailing: self.view.trailingAnchor
        )
        
        searchCityTableView.anchor(
            top: searchCitySearchBar.bottomAnchor,
            leading: self.view.leadingAnchor,
            bottom: self.view.bottomAnchor,
            trailing: self.view.trailingAnchor)
    }
    
    private func reloadSearchedCityTableView() {
        searchCityTableView.reloadData()
    }
    
    // MARK: - TableView Empty states
    private func initialEmptyStateViewMessage() {
        searchCityTableView.setEmptyState(
            with: AppConstants.EmptyStateViewConstant.nothingToShowTitleConstant,
            message: AppConstants.EmptyStateViewConstant.nothingToShowMessageConstant
        )
    }
    
    private func noResultFoundEmptyStateViewMessage() {
        searchCityTableView.setEmptyState(
            with: AppConstants.EmptyStateViewConstant.noReusltToShowTitleConstant,
            message: AppConstants.EmptyStateViewConstant.noReusltToShowMessageConstant
        )
    }
    
    // MARK: - Create Menu Items
    private func createTemperatureMenu(actionTitle: String? = nil) -> UIMenu {
        let menu = UIMenu(title: "Temperature Unit", children: [
            UIAction(title: TemperatureUnit.kelvin.rawValue) { [unowned self] action in
                TemperatureUnitManager.sharedInstance.currentTemperatureUnit = .kelvin
                self.temperatureUnitRightBarButton.menu = createTemperatureMenu(actionTitle: action.title)
            },
            UIAction(title: TemperatureUnit.fahrenheit.rawValue) { [unowned self] action in
                TemperatureUnitManager.sharedInstance.currentTemperatureUnit = .fahrenheit
                self.temperatureUnitRightBarButton.menu = createTemperatureMenu(actionTitle: action.title)
            },
            UIAction(title: TemperatureUnit.celsius.rawValue) { [unowned self] action in
                TemperatureUnitManager.sharedInstance.currentTemperatureUnit = .celsius
                self.temperatureUnitRightBarButton.menu = createTemperatureMenu(actionTitle: action.title)
            }
        ])
        
        if let actionTitle = actionTitle {
            menu.children.forEach { action in
                guard let action = action as? UIAction else {
                    return
                }
                if action.title == actionTitle {
                    action.state = .on
                }
            }
        } else {
            let action = menu.children.first as? UIAction
            action?.state = .on
        }
        return menu
    }
    
    private func changeTemperatureUnitMenuLeftBarItem() {
        temperatureUnitRightBarButton = UIBarButtonItem(
            image: UIImage(systemName: "thermometer.sun"),
            menu: createTemperatureMenu()
        )
        navigationItem.leftBarButtonItem = temperatureUnitRightBarButton
    }
    
    
    // MARK: - Offline saved cities Bar button
    private func saveForOfflineAccessRightBarButton() {
        let saveButton = UIBarButtonItem(
            image: UIImage(systemName: "icloud.slash"),
            style: .plain,
            target: self,
            action: #selector(saveButtonAction(sender:))
        )
        navigationItem.rightBarButtonItem = saveButton
    }
    
    @objc
    func saveButtonAction(sender: UIBarButtonItem) {
        searchCityCoordinator?.pushToSavedOfflineCitiesWeatherList()
    }
    
}

// MARK: - WeatherViewController
extension SearchCityViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchCityViewModel.performSearch(text: searchText)
    }
}

// MARK: - UITableViewDataSource
extension SearchCityViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        searchCityViewModel.numberOfRowsInSearchCityTable
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: SearchWeatherCityTableViewCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
        if searchCityViewModel.isLoading {
            cell.configureAsLoadingCell()
        } else {
            cell.configure(for: searchCityViewModel.getSearchedCity(at: indexPath))
        }
        return cell
    }
}

// MARK: - UITableViewDelegate
extension SearchCityViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        searchCityCoordinator?.pushToWeatherScreen(with: searchCityViewModel.getSearchedCity(at: indexPath))
    }
}
