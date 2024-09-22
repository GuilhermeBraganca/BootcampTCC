//
//  LoginViewModel.swift
//  JaChegou
//
//  Created by Fabio Cristiano Lopes on 15/09/24.
//
//
// LoginViewModel centraliza a validação de e-mail e senha e interação com a LoginViewController

import Foundation

class LoginViewModel {
    var isLoginButtonEnabled: ((Bool) -> Void)? // Habilitar ou desabilitar o botão login
    var showEmailError: ((Bool) -> Void)? //Mostrar ou ocultar a mensagem de erro de e-mail
    var showPasswordError: ((Bool) -> Void)? //Mostrar ou ocultar a mensagem de erro de senha


    // Função para validar o e-mail e a senha
    func validateLogin(email: String?, password: String?) {
        let isEmailValid = isValidEmail(email)      // Valida o e-mail
        let isPasswordValid = isValidPassword(password) // Valida a senha
        
        // Verifica qual campo está incorreto e exibe mensagem de erro
        if !isEmailValid {
            showEmailError?(true)  // Exibe erro de e-mail
            showPasswordError?(false) // Esconde erro de senha
        } else if !isPasswordValid {
            showEmailError?(false) // Esconde erro de e-mail
            showPasswordError?(true) // Exibe erro de senha
        } else {
            showEmailError?(false) // Esconde erro de e-mail
            showPasswordError?(false) // Esconde erro de senha
        }
        
        // Somente habilita o botão de login se ambos os campos forem válidos
        let isValid = isEmailValid && isPasswordValid
        isLoginButtonEnabled?(isValid) // Atualiza o estado do botão de login
    }
    
    // Função privada para validar o formato do e-mail
    private func isValidEmail(_ email: String?) -> Bool {
        guard let email = email, !email.isEmpty else { return false }
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Z|a-z]{2,}"
        let emailPred = NSPredicate(format: "SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
    
    // Função para validar a senha
    private func isValidPassword(_ password: String?) -> Bool {
        guard let password = password, !password.isEmpty else { return false } // Retorna falso se a senha for nula ou vazia
        return password.count >= 6 // Verifica se a senha tem pelo menos 6 caracteres
    }
}





