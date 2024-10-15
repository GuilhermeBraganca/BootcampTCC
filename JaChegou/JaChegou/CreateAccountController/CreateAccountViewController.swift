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
        print(#function)
    }
    
    func tappedEyeConfirmPasswordButton() {
        print(#function)
    }
    
    func tappedRegisterButton() {
        let loginVC = LoginViewController()
        navigationController?.pushViewController(loginVC, animated: true)
    }
    
    func tappedLoginButton() {
        viewModel.user.birthDate = screen?.birthDateTextField.text ?? ""
        viewModel.user.email = screen?.emailTextField.text ?? ""
        viewModel.user.password = screen?.passwordTextField.text ?? ""
        viewModel.user.name = screen?.nameTextField.text ?? ""
        
        viewModel.createUser { [weak self] result in
            switch result {
            case .success:
                self?.successAlert()
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func successAlert() {
        let alert = UIAlertController(title: "PARABÉNS", message: "Conta criada com sucesso!", preferredStyle: .alert)
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
        print(#function)
        textField.layer.borderColor = UIColor.blue.cgColor
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if let text = textField.text as NSString? {
            let newText = text.replacingCharacters(in: range, with: string)
            textField.text = newText
            if UITextView.isValidEmail(screen?.emailTextField.text ?? "") &&
               UITextView.isValidPassword(screen?.passwordTextField.text ?? "") &&
               UITextView.isValidConfirmPassword(screen?.confirmPasswordTextField.text ?? "") {
                isEnabledLoginButton(isEnable: true)
            } else {
                isEnabledLoginButton(isEnable: false)
            }
        }
        return false
    }
}





