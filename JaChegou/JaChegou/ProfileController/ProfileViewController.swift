//
//  ProfileControllerViewController.swift
//  JaChegou
//
//  Created by MacBook on 11/08/24.
//

import UIKit
import FirebaseFirestoreInternal

class ProfileViewController: UIViewController {
    var screen: ProfileScreen?
    var viewModel: ProfileViewModel = ProfileViewModel()
    
    override func loadView() {
        screen = ProfileScreen()
        view = screen
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configProtocols()
        viewModel.delegate = self
        getUserData()
    }
    
    func getUserData() {
        viewModel.fetchUserData()
    }
    
    func configProtocols() {
        screen?.delegate = self
    }
    
    func showAlert(message: String) {
        let alert = UIAlertController(title: "Erro", message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(okAction)
        self.present(alert, animated: true, completion: nil)
    }
}

extension ProfileViewController: ProfileScreenProtocol {
    func tappedOutOfAccountButton() {
        showLogoutAlert()
    }
    
    func showLogoutAlert() {
        let alert = UIAlertController(title: "Sair da conta", message: "Tem certeza que deseja sair da sua conta?", preferredStyle: .alert)
        let logoutAction = UIAlertAction(title: "Sair", style: .destructive) { _ in
            print("Usuário saiu da conta.")
            self.logoutAndNavigateToLogin()
        }
        let cancelAction = UIAlertAction(title: "Cancelar", style: .cancel, handler: nil)
        alert.addAction(logoutAction)
        alert.addAction(cancelAction)
        self.present(alert, animated: true, completion: nil)
    }
    
    func tappedDeleteAccountButton() {
        showDeleteAccountAlert()
    }
    
    func logoutAndNavigateToLogin() {
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
           let window = windowScene.windows.first {
            let loginViewController = LoginViewController()
            let navigationController = UINavigationController(rootViewController: loginViewController)
            
            window.rootViewController = navigationController
            window.makeKeyAndVisible()
            
            UIView.transition(with: window, duration: 0.5, options: .transitionCrossDissolve, animations: nil, completion: nil)
        }
    }
    
    func showDeleteAccountAlert() {
        let alert = UIAlertController(title: "Atenção", message: "Tem certeza que deseja excluir esta conta?", preferredStyle: .alert)
        let deleteAction = UIAlertAction(title: "Excluir", style: .destructive) { [weak self] _ in
            self?.viewModel.deleteUserAccount()
        }
        let cancelAction = UIAlertAction(title: "Cancelar", style: .cancel, handler: nil)
        alert.addAction(deleteAction)
        alert.addAction(cancelAction)
        self.present(alert, animated: true, completion: nil)
    }
}

extension ProfileViewController: ProfileViewModelDelegate {
    func didFetchUserData(_ user: User) {
        DispatchQueue.main.async { [weak self] in
            self?.screen?.birthDataTextField.text = user.birthDate
            self?.screen?.emailTextField.text = user.email
            self?.screen?.nameTextField.text = user.name
        }
    }
    
    func didFailFetchingUserData(with error: Error) {
        DispatchQueue.main.async { [weak self] in
            self?.showAlert(message: "Erro ao recuperar os dados: \(error.localizedDescription)")
        }
    }
    
    func didDeleteUserAccount() {
        DispatchQueue.main.async { [weak self] in
            self?.logoutAndNavigateToLogin()
        }
    }
    
    func didFailDeletingUserAccount(with error: Error) {
        DispatchQueue.main.async { [weak self] in
            self?.showAlert(message: "Erro ao excluir a conta: \(error.localizedDescription)")
        }
    }
}

extension ProfileViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
