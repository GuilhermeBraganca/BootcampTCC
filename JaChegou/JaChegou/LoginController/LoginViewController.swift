
import UIKit

class LoginViewController: UIViewController {
    
    var screen: LoginScreen?
    var viewModel = LoginViewModel()
    
    override func loadView() {
        screen = LoginScreen()
        view = screen
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        configProtocols()
        interactionLoginViewModel() //interação com a LoginViewModel.
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
    
    // Função para interação da LoginViewController (View) com a interactionLoginViewModel.
    func interactionLoginViewModel() {
        viewModel.isLoginButtonEnabled = { [weak self] isEnabled in
            self?.isEnabledLoginButton(isEnable: isEnabled)
        }
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
            
            // Atualiza o ViewModel com os novos valores dos campos
            viewModel.validateLogin(email: screen?.emailTextField.text, password: screen?.passwordTextField.text)
        }
        return false
    }
}


