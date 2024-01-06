//
//  SceneDelegate.swift
//  WeatherApp-MVVM
//
//  Created by Eken Özlü on 5.01.2024.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        ConnectionManager.shared.configure()
        
        setNavigationBarStyle()
        window = UIWindow(windowScene: windowScene)
        window?.rootViewController = TabBarController()
        window?.makeKeyAndVisible()
    }
    
    func sceneDidDisconnect(_ scene: UIScene) {
    }
    
    func sceneDidBecomeActive(_ scene: UIScene) {
    }
    
    func sceneWillResignActive(_ scene: UIScene) {
    }
    
    func sceneWillEnterForeground(_ scene: UIScene) {
    }
    
    func sceneDidEnterBackground(_ scene: UIScene) {
        (UIApplication.shared.delegate as? AppDelegate)?.saveContext()
    }
    
    func setNavigationBarStyle() {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .clrLightPink
        appearance.titleTextAttributes = [.foregroundColor : UIColor.clrMainPurple,
                                          .font : UIFont.systemFont(ofSize: 18, weight: .bold)]
        UINavigationBar.appearance().standardAppearance = appearance
        UINavigationBar.appearance().scrollEdgeAppearance = appearance
        UINavigationBar.appearance().compactAppearance = appearance
        UINavigationBar.appearance().tintColor = .clrMainPurple
        UINavigationBar.appearance().layer.shadowOffset = CGSize(width: 0, height: 0)
        UINavigationBar.appearance().layer.shadowRadius = 4
        UINavigationBar.appearance().layer.shadowColor = UIColor.clrBlack.cgColor
        UINavigationBar.appearance().layer.shadowOpacity = 0.3
        
    }
    
}

