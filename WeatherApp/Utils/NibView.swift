//
//  NibView.swift
//  WeatherApp
//
//  Created by Gagan Vishal  on 2023/02/23.
//

import UIKit

class NibView: UIView {
    
    var view: UIView!
    
    // MARK: - View Life cycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        xibSetup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        xibSetup()
    }
    
}

private extension NibView {
    func xibSetup() {
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = UIColor.clear
        view = loadNib()
        addSubview(view)
        view.fillSuperview()
    }
}
