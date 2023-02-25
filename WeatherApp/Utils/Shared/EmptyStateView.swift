//
//  EmptyStateView.swift
//  WeatherApp
//
//  Created by Gagan Vishal  on 2023/02/23.
//

import UIKit

final class EmptyStateView: UIView {
    
    private let logoImageView: UIImageView = {
        let imageView = UIImageView(image: Image.weatherImage)
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private let headlineLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let subtitleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.spacing = 8
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup
    private func setup() {
        setupView()
    }
    
    private func setupView() {
        let guide = safeAreaLayoutGuide
        self.backgroundColor = UIColor.white
        [logoImageView, headlineLabel, subtitleLabel].forEach { view in
            stackView.addArrangedSubview(view)
        }
        addSubviews( stackView )
        stackView.anchor(
            top: nil,
            leading: guide.leadingAnchor,
            bottom: nil,
            trailing: guide.trailingAnchor
        )
        stackView.centerInSuperview()
        setupFonts()
    }
    
    func configure(
        titleText: String,
        subtitleText: String,
        image: UIImage? = nil
    ) {
        self.headlineLabel.text = titleText
        self.subtitleLabel.text = subtitleText
        if let image = image {
            self.logoImageView.image = image
        }
    }
    
    private func setupFonts() {
        headlineLabel.numberOfLines = 3
        subtitleLabel.numberOfLines = 4
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setupFonts()
    }
    
}
