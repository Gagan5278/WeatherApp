//
//  WeatherInfoView.swift
//  WeatherApp
//
//  Created by Gagan Vishal  on 2023/02/23.
//

import UIKit

class WeatherInfoView: NibView {
    
    @IBOutlet weak var feelsLikeLabel: UILabel!
    @IBOutlet weak var locationNameLabel: UILabel!
    @IBOutlet weak var weatherDescriptionLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var weatherImageView: CustomImageView!
    
    // MARK: - View life cycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        drawCornerRadius()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        drawCornerRadius()
    }
    
    var weatherModel: WeatherDetailViewItem! {
        didSet {
            locationNameLabel.text = weatherModel.locationName
            weatherDescriptionLabel.text = weatherModel.weatherDescription
            temperatureLabel.text = weatherModel.currentTemperatureInUnit
            weatherImageView.fetchImageFrom(endPoint: weatherModel.weatherIcon)
            feelsLikeLabel.text = weatherModel.feelsLikeTemperatureInUnit
        }
    }
    
}
