//
//  ProfileControllerViewController.swift
//  JaChegou
//
//  Created by MacBook on 11/08/24.
//
import UIKit

class ProfileControllerViewController: UIViewController {
    var screen: ProfileScreen?
    var viewModel: ProfileViewModel!
    
    override func loadView() {
        screen = ProfileScreen()
        view = screen
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configProtocols()
        viewModel = ProfileViewModel(email: "teste@teste.com.br", password: "123456")
    }
    
    func configProtocols() {
        screen?.delegate = self
    }
}

extension ProfileControllerViewController: ProfileScreenProtocol {
    
    func tappedEditButton(isEditing: Bool) {
        if isEditing {
            // Se a edição estiver ativada, os campos poderão ser editados
            print("Modo de edição ativado")
        } else {
            // Após a edição, vamos validar os campos
            guard let email = screen?.emailTextField.text,
                  let password = screen?.passwordTextField.text else { return }
            
            if viewModel.validateFields(email: email, password: password) {
                print("Campos válidos")
            } else {
                print("Erro na validação dos campos")
            }
        }
    }
    
    func tappedOutOfAccountButton() {
        print(#function)
    }
    
    func tappedDeleteAccountButton() {
        print(#function)
    }
}
