
import UIKit

class LoginViewController: UIViewController {
    
    var screen: LoginScreen?
    
    override func loadView() {
        screen = LoginScreen()
        view = screen
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.backButtonTitle = ""
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
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

extension LoginViewController: LoginScreenProtocol {
    func tappedRegisterButton() {
        navigationController?.pushViewController(CreateAccountViewController(), animated: true)
    }
    
    func tappedLoginButton() {
        navigationController?.pushViewController(MainTabBarControllerViewController(), animated: true)
    }
}

extension LoginViewController: UITextFieldDelegate {
    
    func tappedRecoverPasswordButton() {
        // Abrir tela nova tela de recuperação de senha
        let recoverPasswordVC = RecoverPasswordViewController()
        navigationController?.pushViewController(recoverPasswordVC, animated: true)
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.layer.borderColor = UIColor.blue.cgColor
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if let text = textField.text as? NSString {
            let newText = text.replacingCharacters(in: range, with: string)
            textField.text = newText
            if UITextView.isValidEmail(screen?.emailTextField.text ?? "") && UITextView.isValidPassword(screen?.passwordTextField.text ?? "") {
                isEnabledLoginButton(isEnable: true)
            } else {
                isEnabledLoginButton(isEnable: true)
            }
        }
        return false
    }
    
}

