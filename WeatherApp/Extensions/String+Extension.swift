//
//  String+Extension.swift
//  WeatherApp
//
//  Created by Gagan Vishal  on 2023/02/22.
//

import Foundation

extension String {
    func appendWhiteSpaceAtEndAfter(adding: String = "") -> Self {
        (self + adding + " ")
    }
}
