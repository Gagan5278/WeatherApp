//
//  WeatherDetailViewController.swift
//  WeatherApp
//
//  Created by Gagan Vishal  on 2023/02/23.
//

import UIKit
import Combine

class WeatherDetailViewController: UIViewController {
    
    var weatherDetailCoordinator: Coordinator?
    private var outputSubscribers = Set<AnyCancellable>()
    var weatherDetailViewModel: WeatherDetailViewModel!
    private var weatherInfoView: WeatherInfoView!
    private var activityIndicator: UIActivityIndicatorView = {
        let actView = UIActivityIndicatorView()
        actView.hidesWhenStopped = true
        actView.startAnimating()
        return actView
    }()
    
    // MARK: - View Controller life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = AppConstants.WeatherDetailViewConstants.navigationTitleConstant
        setupWeatherInfoViewAndApplyConstraints()
        bindWeatherViewModel()
        saveForOfflineAccessRightBarButton()
        loadWetaherForSelectedCity()
    }
    
    convenience init(viewModel: WeatherDetailViewModel) {
        self.init(nibName: nil, bundle: nil)
        weatherDetailViewModel = viewModel
    }
        
    // MARK: - Bind View Model
    private func bindWeatherViewModel() {
        weatherDetailViewModel.weatherRequestOutput
            .sink { [weak self ] eventOutput in
                switch eventOutput {
                case .fetchWeatherDidSucceed(let weather):
                    self?.showWeatherInfoView(with: weather)
                case .fetchWeatherDidFail, .fetchWeatherDidSucceedWithEmptyData:
                    self?.showErrorAlert()
                case .initialState: break
                }
            }
            .store(in: &outputSubscribers)
    }
    
    private func loadWetaherForSelectedCity() {
        weatherDetailViewModel.loadWeatherDetail()
    }
    
    private func setupWeatherInfoViewAndApplyConstraints() {
        weatherInfoView = WeatherInfoView()
        view.addSubviews(weatherInfoView, activityIndicator)
        weatherInfoView.anchor(
            top: view.safeAreaLayoutGuide.topAnchor,
            leading: view.leadingAnchor,
            bottom: nil,
            trailing: view.trailingAnchor,
            padding: UIEdgeInsets(
                top: AppConstants.commonPadingConstants,
                left: AppConstants.commonPadingConstants,
                bottom: AppConstants.commonPadingConstants,
                right: AppConstants.commonPadingConstants
            )
        )
        weatherInfoView.isHidden = true
        activityIndicator.centerInSuperview()
    }
    
    private func showWeatherInfoView(with weather: WeatherDetailViewItem) {
        guard  weatherInfoView != nil else {
            fatalError()
        }
        weatherInfoView!.weatherModel = weather
        weatherInfoView.isHidden = false
        activityIndicator.stopAnimating()
    }

    // MARK: - Show Error alert message
    private func showErrorAlert() {
        self.showAlertWith(
            title: AppConstants.WeatherDetailViewConstants.errorAlertTitleConstant,
            message: AppConstants.WeatherDetailViewConstants.errorAlertMessageConstant,
            firstButtonTitle: "OK"
        )
    }
    
    // MARK: - Offline Right Bar Item
    private func saveForOfflineAccessRightBarButton() {
        let saveButton = UIBarButtonItem(
            image: UIImage(systemName: "plus.app"),
            style: .plain,
            target: self,
            action: #selector(saveButtonAction(sender:))
        )
        navigationItem.rightBarButtonItem = saveButton
    }
    
    @objc
    private func saveButtonAction(sender: Any) {
        self.showAlertWith(
            title: AppConstants.WeatherDetailViewConstants.saveCityAlertTitleConstant,
            message: AppConstants.WeatherDetailViewConstants.saveCityAlertMessageConstant,
            firstButtonTitle: AppConstants.WeatherDetailViewConstants.saveCityAlertFirstButtonTitleConstant,
            secondButtonTitle: AppConstants.WeatherDetailViewConstants.saveCityAlertSecondButtonTitleConstant,
            secondButtonStyle: .destructive,
            withFirstCallback: saveSelectedCityForOfflineAccess(action:)
        )
    }
    
    private func saveSelectedCityForOfflineAccess(action: UIAlertAction?) {
        weatherDetailViewModel.saveSelectedCityForOfflineAccess()
    }
    
}
