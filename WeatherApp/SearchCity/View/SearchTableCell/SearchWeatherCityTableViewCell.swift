//
//  SearchWeatherCityTableViewCell.swift
//  WeatherApp
//
//  Created by Gagan Vishal  on 2023/02/23.
//

import UIKit

class SearchWeatherCityTableViewCell: UITableViewCell {
    
    @IBOutlet weak var cityTitleLabel: UILabel!
    @IBOutlet weak var citySubTitleLabel: UILabel!
    
    var searchedCityLocation: SearchCityModel?
    
    // MARK: - View Life cycle
    override func awakeFromNib() {
        super.awakeFromNib()
        setupDesign()
    }
    
    private func setupDesign() {
        cityTitleLabel.textColor = .appPrimaryColor
        citySubTitleLabel.textColor = .appSecondaryColor
    }
    
    func configure(for location: SearchCityModel) {
        self.searchedCityLocation = location
        setupLabels()
    }
    
    func configureAsLoadingCell() {
        cityTitleLabel.text = AppConstants.SearchCityViewConstants.loadingCityOnTableCellConstant
        citySubTitleLabel.text = AppConstants.SearchCityViewConstants.loadingCountryOnTableCellConstant
        searchedCityLocation = nil
    }
    
    private func setupLabels() {
        cityTitleLabel.text = searchedCityLocation?.name
        let state = searchedCityLocation?.state ?? ""
        let country = searchedCityLocation?.country ?? ""
        citySubTitleLabel.text = state
        if state.isEmpty {
            citySubTitleLabel.text = country
        } else {
            citySubTitleLabel.text = state.appendWhiteSpaceAtEndAfter(adding: ",") + country
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.configureAsLoadingCell()
    }
    
}
