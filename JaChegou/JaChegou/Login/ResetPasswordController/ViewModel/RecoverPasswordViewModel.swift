//
//  RecoverPasswordViewModel.swift
//  JaChegou
//
//  Created by Fabio Cristiano Lopes on 15/09/24.
//

import Foundation
import FirebaseAuth
import UIKit

protocol RecoveryPasswordProtocol: AnyObject {
    func showAlert(title: String, message: String)
}

class RecoverPasswordViewModel {
    
    var delegate: RecoveryPasswordProtocol?
    
    func recoverPassword(for email: String?) {
        guard let email = email, ValidationData.isValidEmail(email) else {
            delegate?.showAlert(title: "Erro", message: "Por favor, insira um e-mail válido.")
            return
        }
        Auth.auth().sendPasswordReset(withEmail: email) { [weak self] error in
            guard let self else { return }
            if let error = error {
                self.delegate?.showAlert (title: "Erro", message: error.localizedDescription)
            } else {
                self.delegate?.showAlert (title: "Sucesso", message: "E-mail de recuperação enviado para \(email).")
            }
        }
    }
}
