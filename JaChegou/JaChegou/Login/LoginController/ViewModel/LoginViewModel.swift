//
//  LoginViewModel.swift
//  JaChegou
//
//  Created by Fabio Cristiano Lopes on 15/09/24.
//
//

import Foundation
import FirebaseAuth

class LoginViewModel {
    var isLoginButtonEnabled: ((Bool) -> Void)?
    var showEmailError: ((Bool) -> Void)?
    var showPasswordError: ((Bool) -> Void)?
    var showLoginError: ((String) -> Void)?
    var didLoginSuccess: (() -> Void)?

    func validateLogin(email: String?, password: String?) {
        let isEmailValid = UITextView.isValidEmail(email ?? "")
        let isPasswordValid = UITextView.isValidPassword(password ?? "")
        
        if !isEmailValid {
            showEmailError?(true)
            showPasswordError?(false)
        } else if !isPasswordValid {
            showEmailError?(false)
            showPasswordError?(true)
        } else {
            showEmailError?(false)
            showPasswordError?(false)
        }
        
        isLoginButtonEnabled?(isEmailValid && isPasswordValid)
    }
    
    func performLogin(email: String, password: String) {
        Auth.auth().signIn(withEmail: email, password: password) { [weak self] authResult, error in
            if let error = error {
                self?.showLoginError?(error.localizedDescription)
            } else {
                self?.didLoginSuccess?()
            }
        }
    }
}
