import UIKit
import FirebaseAuth

class LoginViewController: UIViewController, LoginViewModelDelegate {
    
    private var screen: LoginScreen?
    private var viewModel = LoginViewModel()
    
    override func loadView() {
        screen = LoginScreen()
        view = screen
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        configProtocols()
        viewModel.delegate = self
    }
    
    func showAlert(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okButton = UIAlertAction(title: "OK", style: .default)
        alertController.addAction(okButton)
        present(alertController, animated: true)
    }

    func setupNavigationBar() {
        navigationItem.backButtonTitle = ""
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    }
    
    func configProtocols() {
        screen?.delegate = self
        screen?.emailTextField.delegate = self
        screen?.passwordTextField.delegate = self
    }
    
    func setLoginButtonEnabled(_ isEnabled: Bool) {
        isEnabledLoginButton(isEnable: isEnabled)
    }

    func displayEmailError(_ hasError: Bool) {
        guard let screen = screen else { return }
        if hasError {
            screen.emailTextField.layer.borderColor = UIColor.red.cgColor
            screen.emailTextField.layer.borderWidth = 1.0
            screen.emailErrorLabel.isHidden = false
            let attributes: [NSAttributedString.Key: Any] = [.foregroundColor: UIColor.red]
            screen.emailTextField.attributedPlaceholder = NSAttributedString(string: "E-mail*", attributes: attributes)
        } else {
            screen.emailTextField.layer.borderColor = UIColor.clear.cgColor
            screen.emailTextField.layer.borderWidth = 0
            screen.emailErrorLabel.isHidden = true
            let attributes: [NSAttributedString.Key: Any] = [.foregroundColor: UIColor.white]
            screen.emailTextField.attributedPlaceholder = NSAttributedString(string: "E-mail*", attributes: attributes)
        }
    }

    func displayPasswordError(_ hasError: Bool) {
        guard let screen = screen else { return }
        if hasError {
            screen.passwordTextField.layer.borderColor = UIColor.red.cgColor
            screen.passwordTextField.layer.borderWidth = 1.0
            screen.passwordErrorLabel.isHidden = false
            let attributes: [NSAttributedString.Key: Any] = [.foregroundColor: UIColor.red]
            screen.passwordTextField.attributedPlaceholder = NSAttributedString(string: "Senha*", attributes: attributes)
        } else {
            screen.passwordTextField.layer.borderColor = UIColor.clear.cgColor
            screen.passwordTextField.layer.borderWidth = 0
            screen.passwordErrorLabel.isHidden = true
            let attributes: [NSAttributedString.Key: Any] = [.foregroundColor: UIColor.white]
            screen.passwordTextField.attributedPlaceholder = NSAttributedString(string: "Senha*", attributes: attributes)
        }
    }

    func displayLoginError(_ message: String) {
        showAlert(title: "Atenção!", message: message)
    }

    func loginSucceeded() {
        switchToMainTabBarController()
    }

    func isEnabledLoginButton(isEnable: Bool) {
        screen?.loginButton.isEnabled = isEnable
        screen?.loginButton.backgroundColor = isEnable ? .systemBlue : .lightGray
    }

    func switchToMainTabBarController() {
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
              let window = windowScene.windows.first else { return }
        
        let mainTabBarController = MainTabBarControllerViewController()
        window.rootViewController = mainTabBarController
        window.makeKeyAndVisible()
        
        UIView.transition(with: window, duration: 0.5, options: .transitionCrossDissolve, animations: nil, completion: nil)
    }
}

extension LoginViewController: LoginScreenProtocol {
    
    func tappedLoginButton() {
        guard let email = screen?.emailTextField.text,
              let password = screen?.passwordTextField.text,
              !email.isEmpty,
              !password.isEmpty else {
            showAlert(title: "Atenção!", message: "Por favor, preencha todos os campos")
            return
        }
        
        viewModel.performLogin(email: email, password: password)
    }
    
    func tappedRegisterButton() {
        navigationController?.pushViewController(CreateAccountViewController(), animated: true)
    }
    
    func tappedRecoverPasswordButton() {
        let recoverPasswordVC = RecoverPasswordViewController()
        navigationController?.pushViewController(recoverPasswordVC, animated: true)
    }
}

extension LoginViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.layer.borderColor = UIColor.blue.cgColor
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if let text = textField.text as NSString? {
            let newText = text.replacingCharacters(in: range, with: string)
            textField.text = newText
            
            viewModel.validateLogin(email: screen?.emailTextField.text, password: screen?.passwordTextField.text)
        }
        return false
    }
}
