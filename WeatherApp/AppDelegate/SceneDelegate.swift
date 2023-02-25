//
//  SceneDelegate.swift
//  WeatherApp
//
//  Created by Gagan Vishal  on 2023/02/21.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)
        setupNavigationBarAppearance()
        let navController = UINavigationController()
        let coordinator = AppCoordinator(navigationContoller: navController)
        coordinator.start()
        window?.rootViewController = navController
        window?.makeKeyAndVisible()
    }
    
    func sceneDidDisconnect(_ scene: UIScene) { }
    
    func sceneDidBecomeActive(_ scene: UIScene) { }
    
    func sceneWillResignActive(_ scene: UIScene) { }
    
    func sceneWillEnterForeground(_ scene: UIScene) { }
    
    // MARK: - NavigationBar Appearance setup
    private func setupNavigationBarAppearance() {
        UINavigationBar.appearance().tintColor = .appPrimaryColor
        UINavigationBar.appearance().scrollEdgeAppearance = UINavigationBarAppearance()
    }
    
}
