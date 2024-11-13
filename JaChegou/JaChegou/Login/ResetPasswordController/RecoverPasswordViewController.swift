//
//  RecoverPasswordViewController.swift
//  JaChegou
//
//  Created by Fabio Cristiano Lopes on 08/09/24.
//

import UIKit

class RecoverPasswordViewController: UIViewController {
    
    var screen: RecoverPasswordScreen?
    var viewModel = RecoverPasswordViewModel()
    
    override func loadView() {
        screen = RecoverPasswordScreen()
        view = screen
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configProtocols()
    }
    
    func configProtocols() {
        viewModel.delegate = self
        screen?.delegate = self
    }
}

extension RecoverPasswordViewController: RecoverPasswordScreenDelegate {
    func tappedSendEmailButton() {
        viewModel.recoverPassword(for: screen?.recoverPasswordTextField.text)
    }
}
extension RecoverPasswordViewController: RecoveryPasswordDelegate {
    func showAlert(title: String , message: String ) {
        Alert.showAlert( title: title , message: message, viewController: self)
    }
}
 
