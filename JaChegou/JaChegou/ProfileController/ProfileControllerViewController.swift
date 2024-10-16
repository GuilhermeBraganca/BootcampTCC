//
//  ProfileControllerViewController.swift
//  JaChegou
//
//  Created by MacBook on 11/08/24.
//

import UIKit
import FirebaseFirestoreInternal

class ProfileControllerViewController: UIViewController {
    
    var screen: ProfileScreen?
    var viewModel: ProfileViewModel = ProfileViewModel()
    
    override func loadView() {
        screen = ProfileScreen()
        view = screen
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configProtocols()
        getUserData()
    }
    func getUserData(){
        FirestoreManager.shared.getUserData{ [weak self] (result: Result<User, Error>) in
            
            DispatchQueue.main.async {
                guard let self = self else { return }
                switch result {
                case .success(let users):
                    self.screen?.birthDataTextField.text = users.birthDate
                    self.screen?.emailTextField.text = users.email
                    self.screen?.passwordTextField.text = users.password
                    
                    
                case .failure(let error):
                    print("Erro ao recuperar os dados: \(error.localizedDescription)")
                }
            }
        }
    }
    
    func configProtocols() {
        screen?.delegate = self
        screen?.emailTextField.delegate = self
        screen?.passwordTextField.delegate = self
        screen?.birthDataTextField.delegate = self
    }
    
    func validateFields() -> Bool {
        guard let email = screen?.emailTextField.text, !email.isEmpty else {
            showAlert(message: "O campo de e-mail não pode estar vazio.")
            return false
        }
        
        if !viewModel.isValidEmail(email) {
            showAlert(message: "Digite um e-mail válido.")
            return false
        }
        
        guard let password = screen?.passwordTextField.text, !password.isEmpty else {
            showAlert(message: "O campo de senha não pode estar vazio.")
            return false
        }
        
        if !viewModel.isValidPassword(password) {
            showAlert(message: "A senha deve ter no mínimo 6 caracteres.")
            return false
        }
        
        guard let dateOfBirth = screen?.birthDataTextField.text, !dateOfBirth.isEmpty else {
            showAlert(message: "O campo de data de nascimento não pode estar vazio.")
            return false
        }
        
        if !viewModel.isValidDateOfBirth(dateOfBirth) {
            showAlert(message: "Digite uma data de nascimento válida no formato DD/MM/AAAA.")
            return false
        }
        
        return true
    }
    
    func showAlert(message: String) {
        let alert = UIAlertController(title: "Erro", message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(okAction)
        self.present(alert, animated: true, completion: nil)
    }
}

extension ProfileControllerViewController: ProfileScreenProtocol {
    
    func tappedEditButton() {
        if validateFields() {
        }
    }
    
    func tappedOutOfAccountButton() {
        showLogoutAlert()
    }
    
    func showLogoutAlert() {
        let alert = UIAlertController(title: "Sair da conta", message: "Tem certeza que deseja sair da sua conta?", preferredStyle: .alert)
        let logoutAction = UIAlertAction(title: "Sair", style: .destructive) { _ in
            print("Usuário saiu da conta.")
            
            //            // Para voltar para a tela RAIZ utilizamos o:
            //            self.navigationController?.popToRootViewController(animated: true)
            
            let vc = LoginViewController()
            vc.modalPresentationStyle = .fullScreen
            vc.modalTransitionStyle = .flipHorizontal
            self.present(vc, animated: true)
            
        }
        let cancelAction = UIAlertAction(title: "Cancelar", style: .cancel, handler: nil)
        alert.addAction(logoutAction)
        alert.addAction(cancelAction)
        self.present(alert, animated: true, completion: nil)
    }
    
    func tappedDeleteAccountButton() {
        showDeleteAccountAlert()
    }
    
    func showDeleteAccountAlert() {
        let alert = UIAlertController(title: "Atenção", message: "Tem certeza que deseja excluir esta conta?", preferredStyle: .alert)
        let deleteAction = UIAlertAction(title: "Excluir", style: .destructive) { _ in
            print("Conta excluída.")
        }
        let cancelAction = UIAlertAction(title: "Cancelar", style: .cancel, handler: nil)
        alert.addAction(deleteAction)
        alert.addAction(cancelAction)
        self.present(alert, animated: true, completion: nil)
    }
}

extension ProfileControllerViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
