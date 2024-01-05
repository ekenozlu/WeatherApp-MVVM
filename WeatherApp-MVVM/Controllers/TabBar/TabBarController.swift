//
//  TabBarController.swift
//  WeatherApp-MVVM
//
//  Created by Eken Özlü on 5.01.2024.
//

import UIKit

final class TabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let appearance = UITabBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .clrLightPink
        tabBar.standardAppearance = appearance
        tabBar.backgroundColor = .clrLightPink
        tabBar.tintColor = .clrMainPurple
        tabBar.unselectedItemTintColor = .clrSecondaryPurple
        
        tabBar.layer.shadowOffset = CGSize(width: 0, height: 0)
        tabBar.layer.shadowRadius = 4
        tabBar.layer.shadowColor = UIColor.clrBlack.cgColor
        tabBar.layer.shadowOpacity = 0.3
        
        let apiManager = APIManager()
        let homeViewModel = HomeViewModel(apiManager: apiManager)
        let homeVC = HomeVC(viewModel: homeViewModel)
        
        let favsViewModel = FavsViewModel()
        let favsVC = FavsVC(viewModel: favsViewModel)
        
        homeVC.tabBarItem = UITabBarItem(title: "World Weather", image: UIImage(systemName: "globe"), tag: 0)
        favsVC.tabBarItem = UITabBarItem(title: "Favourites", image: UIImage(systemName: "star.fill"), tag: 1)
        
        let firstNavController = UINavigationController(rootViewController: homeVC)
        let secondNavController = UINavigationController(rootViewController: favsVC)
        
        viewControllers = [firstNavController, secondNavController]
    }
}
