//
//  SavedCityWeatherTableViewCell.swift
//  WeatherApp
//
//  Created by Gagan Vishal  on 2023/02/24.
//

import UIKit

class SavedCityWeatherTableViewCell: UITableViewCell {
    
    @IBOutlet weak var weatherInfoView: WeatherInfoView!
    
    // MARK: - View life cycle
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    var savedCityEntity: SavedCityEntity! {
        didSet {
            let weatherModel = WeatherModel(
                weather: [
                    Weather(
                        weatherDescription: savedCityEntity.weatherDescription ?? "",
                        icon: savedCityEntity.iconName ?? ""
                    )
                ],
                main: Main(
                    temp: savedCityEntity.currentTemperature,
                    feelsLike: savedCityEntity.feelsLike
                ),
                sys: Sys(country: savedCityEntity.countryName ?? "" ),
                name: savedCityEntity.cityName ?? "",
                id: Int(savedCityEntity.cityID))
            weatherInfoView.weatherModel = WeatherDetailViewItem(weatherModel: weatherModel)
        }
    }
    
}
