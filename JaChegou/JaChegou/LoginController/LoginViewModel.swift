//
//  LoginViewModel.swift
//  JaChegou
//
//  Created by Fabio Cristiano Lopes on 15/09/24.
//

import Foundation

// LoginViewModel centraliza a validação de e-mail e senha e interação com a LoginViewController
class LoginViewModel {
    
    // Observables para a view
    var isLoginButtonEnabled: ((Bool) -> Void)?
    
    // Método para validar o modelo de login
    func validateLogin(email: String?, password: String?) {
        let isValid = isValidEmail(email) && isValidPassword(password)
        isLoginButtonEnabled?(isValid)
    }
    
    private func isValidEmail(_ email: String?) -> Bool {
        guard let email = email, !email.isEmpty else { return false }
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Z|a-z]{2,}"
        let emailPred = NSPredicate(format: "SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
    
    private func isValidPassword(_ password: String?) -> Bool {
        guard let password = password, !password.isEmpty else { return false }
        // Verificar comprimento mínimo e outros critérios, se necessário
        return password.count >= 6
    }
}


