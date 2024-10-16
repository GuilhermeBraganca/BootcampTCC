import UIKit

class MainTabBarControllerViewController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self // Define o delegate para o TabBarController
        
        self.navigationItem.hidesBackButton = true
        let homeController = createNavController(viewController: HomeViewController(), title: "", imageName: "house")
        let trackingController = createNavController(viewController: TrackingViewController(), title: "", imageName: "plus.square.fill")
        let profileController = createNavController(viewController: ProfileViewController(), title: "", imageName: "person.circle.fill")
        let notificationController = createNavController(viewController: NotificationViewController(), title: "", imageName: "bell")
        
        viewControllers = [homeController, trackingController, profileController, notificationController]
        customizeTabBarAppearance()
    }
    
    private func createNavController(viewController: UIViewController, title: String, imageName: String) -> UINavigationController {
        let navController = UINavigationController(rootViewController: viewController)
        navController.tabBarItem.title = title
        navController.tabBarItem.image = UIImage(systemName: imageName)
        navController.delegate = self
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
extension MainTabBarControllerViewController : UITabBarControllerDelegate, UINavigationControllerDelegate{
    // Desabilita animações durante a troca de abas
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        UIView.setAnimationsEnabled(false)
        return true
    }
    
    // Habilita animações após a troca de abas
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        UIView.setAnimationsEnabled(true)
    }
}
