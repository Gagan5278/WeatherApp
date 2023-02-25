//
//  CustomImageView.swift
//  WeatherApp
//
//  Created by Gagan Vishal  on 2023/02/22.
//

import UIKit
import Combine

protocol DownloadImageProtocol {
    init(request: NetworkServiceProtocol)
    func fetchImageFrom(endPoint: EndPointProtocol)
}

class CustomImageView: UIImageView, DownloadImageProtocol {
    
    private var urlString: String = ""
    private var cancellable: AnyCancellable?
    private var apiClient: NetworkServiceProtocol!
    private let questionMarkSystemImage = UIImage(systemName: "questionmark.circle")!.withTintColor(
        .appPrimaryColor,
        renderingMode: .alwaysOriginal
    )
    
    private let activityIndicator: UIActivityIndicatorView = {
        let actView  = UIActivityIndicatorView()
        actView.hidesWhenStopped = true
        return actView
    }()
    
    // MARK: - init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupActivityIndicator()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        if apiClient == nil {
            apiClient = NetworkService()
        }
    }
    
    required convenience init(request: NetworkServiceProtocol = NetworkService()) {
        self.init(frame: .zero)
        apiClient = request
        contentMode = .scaleAspectFit
    }
    
    // MARK: - Activity indicator setup
    private func setupActivityIndicator() {
        addSubview(activityIndicator)
        activityIndicator.centerInSuperview()
    }
    
    private func stopAnimation() {
        activityIndicator.stopAnimating()
    }
    
    // MARK: - Fetch image from given end point
    func fetchImageFrom(endPoint: EndPointProtocol) {
        activityIndicator.startAnimating()
        urlString = endPoint.requestURLString
        if let cachedImage = ImageCache.getImage(for: endPoint.requestURLString as NSString) {
            self.image = cachedImage
            stopAnimation()
            return
        }
        
        self.image = questionMarkSystemImage
        self.cancellable =  apiClient.fetchWeatherIcon(from: endPoint)
            .sink(receiveCompletion: { compltion in
                switch compltion {
                case .finished, .failure(_): break
                }
            }, receiveValue: { [weak self] imageDownloaded in
                guard let imageToCache = imageDownloaded else {
                    self?.stopAnimation()
                    return
                }
                if self?.urlString == endPoint.requestURLString {
                    self?.image = imageToCache
                    ImageCache.store(
                        image: imageToCache,
                        for: endPoint.requestURLString
                    )
                    self?.stopAnimation()
                }
            })
    }
    
}
