//
//  LoginViewModel.swift
//  JaChegou
//
//  Created by Fabio Cristiano Lopes on 15/09/24.
//
//

import Foundation
import FirebaseAuth

protocol LoginViewModelProtocol: AnyObject {
    func setLoginButtonEnabled(_ isEnabled: Bool)
    func displayEmailError(_ hasError: Bool)
    func displayPasswordError(_ hasError: Bool)
    func displayLoginError(_ message: String)
    func loginSucceeded()
}

class LoginViewModel {
    
    weak var delegate: LoginViewModelProtocol?
    
    func validateLogin(email: String?, password: String?) {
        let isEmailValid = ValidationData.isValidEmail(email ?? "")
        let isPasswordValid = ValidationData.isValidPassword(password ?? "")
        if !isEmailValid {
            delegate?.displayEmailError(true)
            delegate?.displayPasswordError(false)
        } else if !isPasswordValid {
            delegate?.displayEmailError(false)
            delegate?.displayPasswordError(true)
        } else {
            delegate?.displayEmailError(false)
            delegate?.displayPasswordError(false)
        }
        delegate?.setLoginButtonEnabled(isEmailValid && isPasswordValid)
    }
    
    func performLogin(email: String, password: String) {
        Auth.auth().signIn(withEmail: email, password: password) { [weak self] authResult, error in
            guard let self else { return }
            if let error {
                self.delegate?.displayLoginError(error.localizedDescription)
            } else {
                self.delegate?.loginSucceeded()
            }
        }
    }
}
