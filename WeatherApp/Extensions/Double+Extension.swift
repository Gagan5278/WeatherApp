//
//  Double+Extension.swift
//  WeatherApp
//
//  Created by Gagan Vishal  on 2023/02/22.
//

import Foundation

extension Double {
    
    func getHumanReadableTemp(with unit: TemperatureUnit) -> String {
        let measurementFormatter = MeasurementFormatter()
        measurementFormatter.unitStyle = .medium
        measurementFormatter.unitOptions = .providedUnit
        measurementFormatter.numberFormatter.maximumFractionDigits = 1
        let measurementInKelvin = Measurement(value: self, unit: UnitTemperature.kelvin)
        switch unit {
        case .fahrenheit:
            return measurementFormatter.string(from: measurementInKelvin.converted(to: .fahrenheit))
        case .celsius:
            return measurementFormatter.string(from: measurementInKelvin.converted(to: .celsius))
        case .kelvin:
            return measurementFormatter.string(from: measurementInKelvin)
        }
    }
    
}
