//
//  MainTabBarControllerViewController.swift
//  JaChegou
//
//  Created by MacBook on 11/08/24.
//

import UIKit

class MainTabBarControllerViewController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.hidesBackButton = true
        let homeController = createNavController(viewController: HomeViewController(), title: "", imageName: "house")
        let trackingController = createNavController(viewController: TrackingViewController(), title: "", imageName: "plus.square.fill")
        let profileController = createNavController(viewController: ProfileControllerViewController(), title: "", imageName: "person.circle.fill")
        let notificationController = createNavController(viewController: NotificationControllerViewController(), title: "", imageName: "bell")
        
        viewControllers = [homeController, trackingController, profileController, notificationController]
        customizeTabBarAppearance()
    }
    
    
    private func createNavController(viewController: UIViewController, title: String, imageName: String) -> UINavigationController {
        let navController = UINavigationController(rootViewController: viewController)
        navController.tabBarItem.title = title
        navController.tabBarItem.image = UIImage(systemName: imageName)
        return navController
    }
    
    private func customizeTabBarAppearance() {
        tabBar.tintColor = .systemBlue
        tabBar.unselectedItemTintColor = .white
        tabBar.backgroundColor = .black
        tabBar.isTranslucent = false
        tabBar.layer.borderColor = UIColor.black.cgColor
        tabBar.layer.borderWidth = 0.1
    }
    
}
