//
//  ProfileControllerViewController.swift
//  JaChegou
//
//  Created by MacBook on 11/08/24.
//

import UIKit

class ProfileControllerViewController: UIViewController {
    
    var screen: ProfileScreen?
    
    override func loadView() {
        screen = ProfileScreen()
        view = screen
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configProtocols()
    }
    
    func configProtocols() {
        screen?.delegate = self
    }
    
    func tappedOutOfAccountButton() {
        print(#function)
    }
    
    func tappedDeleteAccountButton() {
        print(#function)
    }
}

extension ProfileControllerViewController: ProfileScreenProtocol {
    
    func tappedEditButton() {
    }
        
//    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
//        if let text = textField.text as? NSString {
//            let newText = text.replacingCharacters(in: range, with: string)
//            textField.text = newText
//            if UITextView.isValidEmail(screen?.emailTextField.text ?? "") && UITextView.isValidPassword(screen?.passwordTextField.text ?? "") {
//                tappedEditButton(isEnable: true)
//            } else {
//                tappedEditButton(isEnable: true)
//            }
//        }
//        return false
//    }
}
