import UIKit

class ProfileViewController: UIViewController {
    
    var screen: ProfileScreen?
    var viewModel = ProfileViewModel()
    
    override func loadView() {
        screen = ProfileScreen()
        view = screen
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.delegate = self
        screen?.delegate = self
        viewModel.fetchUserData()
    }
    
    func logoutAndNavigateToLogin() {
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
           let window = windowScene.windows.first {
            let loginViewController = LoginViewController()
            let navigationController = UINavigationController(rootViewController: loginViewController)
            window.rootViewController = navigationController
            window.makeKeyAndVisible()
            UIView.transition(with: window, duration: 0.5, options: .transitionCrossDissolve, animations: nil)
        }
    }
}

extension ProfileViewController: ProfileViewModelDelegate {
    func successFetchUserData(user: User) {
        screen?.nameTextField.text = user.name
        screen?.birthDataTextField.text = user.birthDate
        screen?.emailTextField.text = user.email
    }
    
    func failureFetchingUserData(errorMessage: String) {
        Alert.showAlert(title: "Erro", message: errorMessage, viewController: self)
    }
    
    func successDeleteUserAccount() {
        logoutAndNavigateToLogin()
    }
    
    func failureDeletingUserAccount(errorMessage: String) {
        Alert.showAlert(title: "Erro", message: errorMessage, viewController: self)
    }
}

extension ProfileViewController: ProfileScreenDelegate {
    func tappedOutOfAccountButton() {
        let logoutAction = UIAlertAction(title: "Sair", style: .destructive) { [weak self] _ in
            self?.logoutAndNavigateToLogin()
        }
        let cancelAction = UIAlertAction(title: "Cancelar", style: .cancel)
        Alert.showAlert(title: "Sair da conta", message: "Tem certeza que deseja sair da sua conta?", viewController: self, actions: [logoutAction, cancelAction])
    }
    
    func tappedDeleteAccountButton() {
        let deleteAction = UIAlertAction(title: "Excluir", style: .destructive) { [weak self] _ in
            self?.viewModel.deleteUserAccount()
        }
        let cancelAction = UIAlertAction(title: "Cancelar", style: .cancel)
        Alert.showAlert(title: "Atenção", message: "Tem certeza que deseja excluir esta conta?", viewController: self, actions: [deleteAction, cancelAction])
    }
}
