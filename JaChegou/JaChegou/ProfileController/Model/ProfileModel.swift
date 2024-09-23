//
//  ProfileModel.swift
//  JaChegou
//
//  Created by Giulia Marinho on 22/09/24.
//

import Foundation

struct ProfileModel {
    
    var email: String
    var password: String

    func isValidEmail() -> Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPred = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        return emailPred.evaluate(with: self.email)
    }
    
    func isValidPassword() -> Bool {
        return self.password.count >= 6 // Defina sua regra de validação de senha
    }
}
