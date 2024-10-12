//
//  ProfileViewModel.swift
//  JaChegou
//
//  Created by Giulia Marinho on 11/10/24.
//

import Foundation

struct ProfileViewModel {
    
    // Validação de e-mail
    func isValidEmail(_ email: String) -> Bool {
        let emailPattern = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailPattern)
        return emailPred.evaluate(with: email)
    }
    
    // Validação de senha
    func isValidPassword(_ password: String) -> Bool {
        let passwordPattern = ".{6,}"  // A senha deve ter pelo menos 6 caracteres
        let passwordPred = NSPredicate(format: "SELF MATCHES %@", passwordPattern)
        return passwordPred.evaluate(with: password)
    }
    
    // Validação de telefone
    func isValidPhone(_ phone: String) -> Bool {
        let phonePattern = "\\(\\d{2}\\) \\d{1} \\d{4}-\\d{4}"  // Exemplo: (00) 9 9999-9999
        let phonePred = NSPredicate(format: "SELF MATCHES %@", phonePattern)
        return phonePred.evaluate(with: phone)
    }
    
    // Validação de data de nascimento
    func isValidDateOfBirth(_ date: String) -> Bool {
        let datePattern = "\\d{2}/\\d{2}/\\d{4}"  // Exemplo: 00/00/0000
        let datePred = NSPredicate(format: "SELF MATCHES %@", datePattern)
        return datePred.evaluate(with: date)
    }
}
