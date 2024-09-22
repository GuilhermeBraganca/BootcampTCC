
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
    //Configura a barra de navegação - botão voltar no superior da tela.
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
            //Habilita ou desabilita o botão de login
            self?.isEnabledLoginButton(isEnable: isEnabled)
        }
        //Configura a exibição do erro do campo e-mail
        viewModel.showEmailError = { [weak self] showError in
            if showError {
                self?.screen?.emailTextField.layer.borderColor = UIColor.red.cgColor
                self?.screen?.emailTextField.layer.borderWidth = 1.0
                self?.screen?.emailErrorLabel.isHidden = false
                let placeholderText = "E-mail*"
                let attributes: [NSAttributedString.Key: Any] = [.foregroundColor: UIColor.red]
                self?.screen?.emailTextField.attributedPlaceholder = NSAttributedString(string: placeholderText, attributes: attributes)
            } else {
                //Utilizado para limpar o erro do campo e-mail
                self?.screen?.emailTextField.layer.borderColor = UIColor.clear.cgColor
                self?.screen?.emailTextField.layer.borderWidth = 0
                self?.screen?.emailErrorLabel.isHidden = true
                let placeholderText = "E-mail*"
                let attributes: [NSAttributedString.Key: Any] = [.foregroundColor: UIColor.white]
                self?.screen?.emailTextField.attributedPlaceholder = NSAttributedString(string: placeholderText, attributes: attributes)
            }
        }
        //Configura a exibição do erro do campo senha
        viewModel.showPasswordError = { [weak self] showError in
            if showError {
                self?.screen?.passwordTextField.layer.borderColor = UIColor.red.cgColor
                self?.screen?.passwordTextField.layer.borderWidth = 1.0
                self?.screen?.passwordErrorLabel.isHidden = false
                let placeholderText = "Senha*"
                let attributes: [NSAttributedString.Key: Any] = [.foregroundColor: UIColor.red]
                self?.screen?.passwordTextField.attributedPlaceholder = NSAttributedString(string: placeholderText, attributes: attributes)
            } else {
                //Utilizado para limpar o erro do campo senha
                self?.screen?.passwordTextField.layer.borderColor = UIColor.clear.cgColor
                self?.screen?.passwordTextField.layer.borderWidth = 0
                self?.screen?.passwordErrorLabel.isHidden = true
                let placeholderText = "Senha*"
                let attributes: [NSAttributedString.Key: Any] = [.foregroundColor: UIColor.white]
                self?.screen?.passwordTextField.attributedPlaceholder = NSAttributedString(string: placeholderText, attributes: attributes)
            }
        }
    }
    
    // Habilita ou desabilita o botão de login
    func isEnabledLoginButton(isEnable: Bool) {
        screen?.loginButton.isEnabled = isEnable
        screen?.loginButton.backgroundColor = isEnable ? .systemBlue : .lightGray
    }
}

extension LoginViewController: LoginScreenProtocol {
    
    func tappedLoginButton() {
        // Valida se os campos de e-mail e senha estão preenchidos
        guard let email: String = screen?.emailTextField.text,
              let password: String = screen?.passwordTextField.text,
              !email.isEmpty,
              !password.isEmpty else {
            showAlert(title: "Atenção!", message: "Por favor, preencha todos os campos")
            return
        }
        //Login com o Firebase
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


