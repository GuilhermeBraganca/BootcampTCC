//
//  CreateAccountViewController.swift
//  JaChegou
//
//  Created by MacBook on 10/08/24.
//
import UIKit


class CreateAccountViewController: UIViewController {
    
    var screen: CreateAccountScreen?
    var user: User = User(id: "", email: "", name: "", password: "", birthDate: "", track: [])
    override func loadView() {
        screen = CreateAccountScreen()
        view = screen
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configProtocols()
    }
    
    func configProtocols() {
        screen?.delegate = self
        screen?.emailTextField.delegate = self
        screen?.passwordTextField.delegate = self
    }
    
    func isEnabledLoginButton(isEnable: Bool) {
        screen?.loginButton.isEnabled = isEnable
        screen?.loginButton.backgroundColor = isEnable ? .systemBlue : .lightGray
    }
}

extension CreateAccountViewController: CreateAccountScreenProtocol {
    func tappedEyePasswordButton() {
        print(#function)
    }
    
    func tappedEyeConfirmPasswordButton() {
        print(#function)
    }
    
    func tappedRegisterButton() {
        print(#function)
    }
    func tappedLoginButton() {
        user.birthDate = screen?.birthDateTextField.text ?? ""
        user.email = screen?.emailTextField.text ?? ""
        user.password = screen?.passwordTextField.text ?? ""
        user.name = screen?.nameTextField.text ?? ""
        
        FirestoreManager.shared.createUserWithEmailAndPassword(user: user) { result in
          switch result {
            case .success:
              print ("criado com sucesso")
            //FirestoreManager.shared.saveJsonDataOnFirebase()
          case .failure(let error):
            print(error.localizedDescription)
          }
        }
        
    }
}

extension CreateAccountViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    func textFieldDidBeginEditing(_ textField: UITextField) {
        print(#function)
        textField.layer.borderColor = UIColor.blue.cgColor
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if let text = textField.text as? NSString {
            let newText = text.replacingCharacters(in: range, with: string)
            textField.text = newText
            if UITextView.isValidEmail(screen?.emailTextField.text ?? "") && UITextView.isValidPassword(screen?.passwordTextField.text ?? "") {
                isEnabledLoginButton(isEnable: true)
            } else {
                isEnabledLoginButton(isEnable: false)
            }
        }
        return false
    }
    
}
