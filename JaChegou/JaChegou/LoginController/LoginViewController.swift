
import UIKit
import FirebaseAuth

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
    
    func tappedLoginButton() {
        
        guard let email: String = screen?.emailTextField.text,
              let password: String = screen?.passwordTextField.text,
              !email.isEmpty,
              !password.isEmpty else {
            showAlert(title: "Atenção!", message: "Por favor, preencha todos os campos")
            return
        }
        
    Auth.auth().signIn(withEmail: email, password: password) { [weak self] authResult, error in
        guard let self else { return }
            
        guard error == nil else {
        self.showAlert(title: "Atenção! Dados de autenticação fornecida está incorreta ou expirou!", message: error?.localizedDescription ?? "")
        return
                
       }
        print("Show, login feito com sucesso!")
        
        // Após confirmação do e-mail e senha, direcionar usuário para HomeControllerScreen
        self.navigationController?.pushViewController(HomeViewController(), animated: true)
    }
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
            
            // Atualiza o ViewModel com os novos valores dos campos
            viewModel.validateLogin(email: screen?.emailTextField.text, password: screen?.passwordTextField.text)
        }
        return false
    }
}


