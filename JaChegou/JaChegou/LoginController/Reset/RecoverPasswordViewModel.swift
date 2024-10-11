//
//  RecoverPasswordViewModel.swift
//  JaChegou
//
//  Created by Fabio Cristiano Lopes on 15/09/24.
//

import Foundation
import FirebaseAuth
import UIKit

class RecoverPasswordViewModel {
    
    var showAlert: ((String, String) -> Void)?
    
    func recoverPassword(for email: String?) {
        guard let email = email, UITextView.isValidEmail(email) else {
            showAlert?("Erro", "Por favor, insira um e-mail válido.")
            return
        }
        
        Auth.auth().sendPasswordReset(withEmail: email) { error in
            if let error = error {
                self.showAlert?("Erro", error.localizedDescription)
            } else {
                self.showAlert?("Sucesso", "E-mail de recuperação enviado para \(email).")
            }
        }
    }
    
}



