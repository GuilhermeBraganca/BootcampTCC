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
        viewModel.delegate = self
        view = screen
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        interactionRecoverViewModel()
    }
    
    func interactionRecoverViewModel() {
        
        screen?.sendEmailButton.addTarget(self, action: #selector(sendEmailButtonTapped), for: .touchUpInside)
    }
    
    @objc func sendEmailButtonTapped() {
        viewModel.recoverPassword(for: screen?.recoverPasswordTextField.text)
    }
}

extension RecoverPasswordViewController: RecoveryPasswordDelegate {
    func showAlert(title: String , message: String ) {
        Alert.showAlert( title: title , message: message, viewController: self)
    }
}
 
