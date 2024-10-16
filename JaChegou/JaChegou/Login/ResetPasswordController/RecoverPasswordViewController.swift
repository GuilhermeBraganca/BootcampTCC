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
        interactionRecoverViewModel() // Interação com a RecoverPasswordViewModel.
    }
    
    func interactionRecoverViewModel() {
        viewModel.showAlert = { [weak self] title, message in
            self?.showAlert(title: title, message: message)
        }
        
        screen?.sendEmailButton.addTarget(self, action: #selector(sendEmailButtonTapped), for: .touchUpInside)
    }
    
    @objc func sendEmailButtonTapped() {
        viewModel.recoverPassword(for: screen?.recoverPasswordTextField.text)
    }
    
    func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
}

