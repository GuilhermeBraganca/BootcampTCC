//
//  RecoverPasswordViewModel.swift
//  JaChegou
//
//  Created by Fabio Cristiano Lopes on 15/09/24.
//

import Foundation
import FirebaseAuth

class RecoverPasswordViewModel {
    
    var showAlert: ((String, String) -> Void)?
    
    func recoverPassword(for email: String?) {
        guard let email = email, isValidEmail(email) else {
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
    
    private func isValidEmail(_ email: String?) -> Bool {
        guard let email = email, !email.isEmpty else { return false }
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Z|a-z]{2,}"
        let emailPred = NSPredicate(format: "SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
}



