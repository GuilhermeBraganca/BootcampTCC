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
    var viewModel: ProfileViewModelProtocol = ProfileViewModel()
    
    override func loadView() {
        screen = ProfileScreen()
        view = screen
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        screen?.delegate = self
        configureDelegates()
        loadUserData()
    }
    
    func configureDelegates() {
        screen?.emailTextField.delegate = self
        screen?.birthDataTextField.delegate = self
    }
    
    func loadUserData() {
        viewModel.fetchUserData { [weak self] result in
            DispatchQueue.main.async {
                guard let self = self else { return }
                switch result {
                case .success(let user):
                    self.screen?.nameTextField.text = user.name
                    self.screen?.birthDataTextField.text = user.birthDate
                    self.screen?.emailTextField.text = user.email
                case .failure(let error):
                    let alert = UIAlertController(title: "Erro", message: "Erro ao recuperar os dados: \(error.localizedDescription)", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .default))
                    self.present(alert, animated: true)
                }
            }
        }
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

extension ProfileViewController: ProfileScreenProtocol {
    func tappedOutOfAccountButton() {
        let alert = UIAlertController(title: "Sair da conta", message: "Tem certeza que deseja sair da sua conta?", preferredStyle: .alert)
        let logoutAction = UIAlertAction(title: "Sair", style: .destructive) { _ in
            self.logoutAndNavigateToLogin()
        }
        let cancelAction = UIAlertAction(title: "Cancelar", style: .cancel)
        alert.addAction(logoutAction)
        alert.addAction(cancelAction)
        present(alert, animated: true)
    }
    
    func tappedDeleteAccountButton() {
        let alert = UIAlertController(title: "Atenção", message: "Tem certeza que deseja excluir esta conta?", preferredStyle: .alert)
        let deleteAction = UIAlertAction(title: "Excluir", style: .destructive) { [weak self] _ in
            guard let self = self else { return }
            self.viewModel.deleteUserAccount { result in
                DispatchQueue.main.async {
                    switch result {
                    case .success:
                        self.logoutAndNavigateToLogin()
                    case .failure(let error):
                        let errorAlert = UIAlertController(title: "Erro", message: "Erro ao excluir a conta: \(error.localizedDescription)", preferredStyle: .alert)
                        errorAlert.addAction(UIAlertAction(title: "OK", style: .default))
                        self.present(errorAlert, animated: true)
                    }
                }
            }
        }
        let cancelAction = UIAlertAction(title: "Cancelar", style: .cancel)
        alert.addAction(deleteAction)
        alert.addAction(cancelAction)
        present(alert, animated: true)
    }
}

extension ProfileViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
