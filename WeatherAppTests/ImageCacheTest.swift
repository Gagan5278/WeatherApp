//
//  ImageCacheTest.swift
//  WeatherAppTests
//
//  Created by Gagan Vishal  on 2023/02/22.
//

import XCTest
@testable import WeatherApp

final class ImageCacheTest: XCTestCase {
    
    private let imageURLToSave = "https:\\test.some.url.com"
    
    override func setUp() { }
    
    override func tearDown() { }
    
    func testSaveGivenImageInCacheAndFectShouldBeNotNil() {
        // Given
        saveImageInCache()
        // When
        let storedImage = ImageCache.getImage(for: imageURLToSave as NSString)
        // Then
        XCTAssertNotNil(storedImage)
    }
    
    func testSaveGivenImageInCacheAndFetchWithDifferentKeyShouldBeNil() {
        // Given
        saveImageInCache()
        // When
        let storedImage = ImageCache.getImage(for: "someRandomString" as NSString)
        // Then
        XCTAssertNil(storedImage)
    }
    
    private func saveImageInCache() {
        ImageCache.store(image: UIImage(systemName: "rectangle.portrait.and.arrow.right.fill")!, for: imageURLToSave)
    }
}
