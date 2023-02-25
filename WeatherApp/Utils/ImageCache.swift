//
//  ImageCache.swift
//  WeatherApp
//
//  Created by Gagan Vishal  on 2023/02/22.
//

import UIKit

class ImageCache {
    
    private static let imageCache = NSCache<NSString, UIImage>()
    
    // MARK: - init
    private init() { }
    
    // MARK: - get image for a specific URL string if exist
    static func getImage(for key: NSString) -> UIImage? {
        return imageCache.object(forKey: key)
    }
    
    // MARK: - Store image in cache against URL string
    static func store(image: UIImage, for urlString: String) {
        imageCache.setObject(image, forKey: urlString as NSString)
    }
    
}
