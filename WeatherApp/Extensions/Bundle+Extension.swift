//
//  Bundle+Extension.swift
//  WeatherApp
//
//  Created by Gagan Vishal  on 2023/02/22.
//

import Foundation

extension Bundle {
    static func infoPlistValue(forKey key: String) -> Any? {
        guard let value = Bundle.main.object(forInfoDictionaryKey: key) else {
            return nil
        }
        return value
    }
}
