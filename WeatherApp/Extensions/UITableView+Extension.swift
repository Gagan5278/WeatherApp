//
//  UITableView+Extension.swift
//  WeatherApp
//
//  Created by Gagan Vishal  on 2023/02/23.
//

import UIKit

public extension UITableView {
    
    func register<T: UITableViewCell>(nib _: T.Type) {
        register(T.nib, forCellReuseIdentifier: T.reuseIdentifier)
    }
    
    func dequeueReusableCell<T: UITableViewCell>(forIndexPath indexPath: IndexPath) -> T {
        guard let cell = dequeueReusableCell(withIdentifier: T.reuseIdentifier, for: indexPath) as? T else {
            fatalError("Dequeing a cell with identifier: \(T.reuseIdentifier) failed.")
        }
        return cell
    }
    
    func setEmptyState(with title: String, message: String, image: UIImage? = nil) {
        guard let superview = superview else { return }
        let backgroundEmptyView = EmptyStateView(
            frame: CGRect(
                x: 0,
                y: 0,
                width: superview.frame.width ,
                height: superview.frame.height
            )
        )
        backgroundView = backgroundEmptyView
        backgroundView?.frame = backgroundEmptyView.bounds
        backgroundEmptyView.configure(titleText: title, subtitleText: message, image: image)
    }
    
    func resetBackgroundView() {
        backgroundView = nil
    }
    
}
