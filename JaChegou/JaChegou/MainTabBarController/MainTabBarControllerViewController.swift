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
        
        let homeController = createNavController(viewController: HomeViewController(), title: "", imageName: "house")
        let trackingController = createNavController(viewController: TrackingControllerViewController(), title: "", imageName: "plus.square.fill")
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
        tabBar.tintColor = .systemBlue // cor dos itens fica black quando selecionado
        tabBar.unselectedItemTintColor = .white // cor dos itens fica lightGray quando não está selecionado
        tabBar.backgroundColor = .black // cor de fundo
        tabBar.isTranslucent = false // serve para não deixar transparente o fundo quando trabalhamos com lista
        tabBar.layer.borderColor = UIColor.black.cgColor // cor da borda
        tabBar.layer.borderWidth = 0.1 // espessura da borda
    }
    
}
