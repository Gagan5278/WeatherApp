//
//  AppConstants.swift
//  WeatherApp
//
//  Created by Gagan Vishal  on 2023/02/22.
//

import Foundation

enum AppConstants {
    static let commonPadingConstants: CGFloat = 10
    static let netowrkErrorAlertButtonTitle = "OK"
}

extension AppConstants {
    enum APIConstants {
        static let baseURLKeyInInfoPlist = "BaseURL"
        static let openWeatherAPITokenKeyInPlist = "OpenWeatherAPIKey"
    }
}

extension AppConstants {
    enum EmptyStateViewConstant {
        static let nothingToShowTitleConstant = "Nothing to show"
        static let nothingToShowMessageConstant = "Please enter a search term to fetch list of your places"
        
        static let noReusltToShowTitleConstant = "No results found"
        static let noReusltToShowMessageConstant = "Please enter a different search term and try again."
    }
}
extension AppConstants {
    enum SearchCityViewConstants {
        static let searchBarPlaceholderConstant = "Search your city..."
        static let navigationTitleConstant = "Search City"
        static let loadingCityOnTableCellConstant = "Loading City..."
        static let loadingCountryOnTableCellConstant = "Loading City..."
    }
}

extension AppConstants {
    enum WeatherDetailViewConstants {
        static let navigationTitleConstant = "Weather"
        static let saveCityAlertTitleConstant = "Message"
        static let saveCityAlertMessageConstant = "Do you want to save weather data for offline access?"
        static let saveCityAlertFirstButtonTitleConstant = "Save"
        static let saveCityAlertSecondButtonTitleConstant = "Not now"
        static let errorAlertTitleConstant = "Error!"
        static let errorAlertMessageConstant = "Something went wrong. Please try again later."
    }
}

extension AppConstants {
    enum SavedCitylViewConstants {
        static let navigationTitleConstant = "Saved Cities"
        static let emptyStateTitleConstant = "Welcome"
        static let emptyStateMessageConstant = "Save your favorite city for offline access from weather detail screen"
    }
}

