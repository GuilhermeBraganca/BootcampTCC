//
//  UITextField.swift
//  JaChegou
//
//  Created by MacBook on 03/09/24.
//

import UIKit
#warning("remover logica de elementos de UI!!!")
extension UITextView {

  static func isValidEmail(_ email: String) -> Bool {
    let emailPattern = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
    let emailPred = NSPredicate(format:"SELF MATCHES %@", emailPattern)
    return emailPred.evaluate(with: email)
  }
  static func isValidPassword(_ password: String) -> Bool {
    let passwordPattern = ".{6,}"
    let passwordPred = NSPredicate(format: "SELF MATCHES %@", passwordPattern)
    return passwordPred.evaluate(with: password)
  }

  static func isValidConfirmPassword(_ password: String) -> Bool {
    let passwordPattern = ".{6,}"
    let passwordPred = NSPredicate(format: "SELF MATCHES %@", passwordPattern)
    return passwordPred.evaluate(with: password)
  }
}

extension String {
  static var isValidEmail: Bool {
    let emailPattern = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
    let emailPred = NSPredicate(format:"SELF MATCHES %@", emailPattern)
    return emailPred.evaluate(with: self)
  }

  static var isValidPassword: Bool {
    let passwordPattern = ".{6,}"
    let passwordPred = NSPredicate(format: "SELF MATCHES %@", passwordPattern)
    return passwordPred.evaluate(with: self)
  }

  static var isValidConfirmPassword: Bool {
    let passwordPattern = ".{6,}"
    let passwordPred = NSPredicate(format: "SELF MATCHES %@", passwordPattern)
    return passwordPred.evaluate(with: self)
  }
}
