//
//  ReusableView.swift
//  WeatherApp
//
//  Created by Gagan Vishal  on 2023/02/23.
//

import UIKit

public protocol NibLoadableView {
    static var nibName: String { get }
    
    static var nib: UINib { get }
}

public extension NibLoadableView where Self: UIView {
    static var nibName: String {
        String(describing: self)
    }
    
    static var nib: UINib {
        UINib(nibName: nibName, bundle: nil)
    }
}

public protocol ReusableView {
    static var reuseIdentifier: String { get }
}

public extension ReusableView where Self: UIView {
    static var reuseIdentifier: String {
        String(describing: self)
    }
}

public protocol XibReusableView: ReusableView, NibLoadableView {}

extension UITableViewCell: XibReusableView {}
