//
//  MockNavigationController.swift
//  WeatherAppTests
//
//  Created by Gagan Vishal  on 2023/02/21.
//

import UIKit

class MockNavigationController: UINavigationController {
    
    var pushViewControllerIsCalled = false
    
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        pushViewControllerIsCalled = true
    }
    
}
