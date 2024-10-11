//
//  LoginViewModel.swift
//  JaChegou
//
//  Created by Fabio Cristiano Lopes on 15/09/24.
//
//
// LoginViewModel centraliza a validação de e-mail e senha e interação com a LoginViewController

import Foundation
import UIKit

class LoginViewModel {
    var isLoginButtonEnabled: ((Bool) -> Void)? // Habilitar ou desabilitar o botão login
    var showEmailError: ((Bool) -> Void)? //Mostrar ou ocultar a mensagem de erro de e-mail
    var showPasswordError: ((Bool) -> Void)? //Mostrar ou ocultar a mensagem de erro de senha


    // Função para validar o e-mail e a senha
    func validateLogin(email: String?, password: String?) {

        let isEmailValid = UITextView.isValidEmail(email ?? "")      // Valida o e-mail
        let isPasswordValid = UITextView.isValidPassword(password ?? "") // Valida a senha
        
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
    
    
}





