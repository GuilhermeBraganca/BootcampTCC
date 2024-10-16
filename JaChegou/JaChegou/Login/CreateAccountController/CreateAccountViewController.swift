//
//  CreateAccountViewController.swift
//  JaChegou
//
//  Created by MacBook on 10/08/24.
//

import UIKit

class CreateAccountViewController: UIViewController {
    
    var screen: CreateAccountScreen?
    var viewModel: CreateAccountViewModel = CreateAccountViewModel()
    
    override func loadView() {
        screen = CreateAccountScreen()
        view = screen
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configProtocols()
    }
    
    func configProtocols() {
        screen?.delegate = self
        screen?.emailTextField.delegate = self
        screen?.passwordTextField.delegate = self
        screen?.nameTextField.delegate = self
        screen?.birthDateTextField.delegate = self
        screen?.confirmPasswordTextField.delegate = self
    }
    
    func isEnabledLoginButton(isEnable: Bool) {
        screen?.loginButton.isEnabled = isEnable
        screen?.loginButton.backgroundColor = isEnable ? .systemBlue : .lightGray
    }
}

extension CreateAccountViewController: CreateAccountScreenProtocol {
    func tappedEyePasswordButton() {
        
    }
    
    func tappedEyeConfirmPasswordButton() {
    
    }
    
    func tappedRegisterButton() {
        navigationController?.popToRootViewController(animated: true)
    }
    
    func tappedLoginButton() {
        
        guard let birthDate: String = screen?.birthDateTextField.text,
              let email: String = screen?.emailTextField.text,
              let password: String = screen?.passwordTextField.text,
              let passwordCheck: String = screen?.confirmPasswordTextField.text,
              let name: String = screen?.nameTextField.text,
              !birthDate.isEmpty,
              !email.isEmpty,
              !password.isEmpty,
              !passwordCheck.isEmpty,
              !name.isEmpty
        else {
            self.showOKAlert(title: "Atenção!", message: "Por favor, preencha todos os campos")
            return
        }
        if password != passwordCheck {
            self.showOKAlert(title: "Atenção!", message: "As senhas não coincidem. Por favor, verifique e tente novamente.")
            return
        }
        
        viewModel.user.birthDate = screen?.birthDateTextField.text ?? ""
        viewModel.user.email = screen?.emailTextField.text ?? ""
        viewModel.user.password = screen?.passwordTextField.text ?? ""
        viewModel.user.name = screen?.nameTextField.text ?? ""
        
        viewModel.createUser { [weak self] result in
            switch result {
            case .success:
                self?.successAlert()
            case .failure(let error):
                self?.errorAlert(error: error.localizedDescription)
            }
        }
    }
    
    func successAlert() {
        let alert = UIAlertController(title: "PARABÉNS", message: "Conta criada com sucesso!", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    func errorAlert(error: String){
        let alert = UIAlertController(title: "Houve um error", message: error, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}

extension CreateAccountViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.layer.borderColor = UIColor.blue.cgColor
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if let text = textField.text as NSString? {
            let newText = text.replacingCharacters(in: range, with: string)
            textField.text = newText
            if UITextView.isValidEmail(screen?.emailTextField.text ?? "") && UITextView.isValidPassword(screen?.passwordTextField.text ?? "") && UITextView.isValidConfirmPassword(screen?.confirmPasswordTextField.text ?? "") {
                isEnabledLoginButton(isEnable: true)
            } else {
                isEnabledLoginButton(isEnable: false)
            }
        }
        return false
    }
}





