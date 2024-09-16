import UIKit


protocol LoginScreenProtocol: AnyObject {
    func tappedLoginButton()
    func tappedRegisterButton()
    func tappedRecoverPasswordButton()
}


class LoginScreen: UIView {
    
    weak var delegate: LoginScreenProtocol?
    
    
    lazy var headerView: HeaderView = {
        let view = HeaderView(title: "Para aproveitar todos os recursos, faça login.", image: UIImage(named: "worldImage"))
        view.translatesAutoresizingMaskIntoConstraints = false
        view.contentMode = .scaleAspectFill
        return view
    }()
    
    
    lazy var loginLabel: UILabel = {
        let label = UILabel()
        label.text = "Para aproveitar todos os recursos, faça login."
        label.numberOfLines = 2
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 20)
        return label
    }()
    
    lazy var subTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Informe seus dados de login"
        label.numberOfLines = 1
        label.lineBreakMode = .byWordWrapping
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 12)
        return label
    }()
    
    
    lazy var emailTextField: UITextField = {
        let tf = UITextField()
        let placeholderText =  "E-mail*"
        let attributes: [NSAttributedString.Key: Any] = [.foregroundColor: UIColor.white]
        tf.attributedPlaceholder = NSAttributedString(string: placeholderText, attributes: attributes)
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.borderStyle = .roundedRect
        tf.backgroundColor = .customGray
        tf.textColor = .white
        tf.layer.cornerRadius = 15
        tf.keyboardType = .emailAddress
        return tf
    }()
    
    lazy var passwordTextField: UITextField = {
        let tf = UITextField()
        let placeholderText =  "Senha*"
        let attributes: [NSAttributedString.Key: Any] = [.foregroundColor: UIColor.white]
        tf.attributedPlaceholder = NSAttributedString(string: placeholderText, attributes: attributes)
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.borderStyle = .roundedRect
        tf.isSecureTextEntry = true
        tf.backgroundColor = .customGray
        tf.textColor = .white
        tf.layer.cornerRadius = 15
        return tf
    }()
    
    lazy var recoverPasswordButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Recuperar Senha", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        button.setTitleColor(.white, for: .normal)
        button.addTarget(self, action: #selector(tappedRecoverPasswordButton), for: .touchUpInside)
        return button
    }()
    
    @objc func tappedRecoverPasswordButton() {
        delegate?.tappedRecoverPasswordButton()
    }
    
    lazy var loginButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("CONFIRMAR", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .systemBlue
        button.clipsToBounds = true
        button.layer.cornerRadius = 15
        button.addTarget(self, action: #selector(tappedLoginButton), for: .touchUpInside)
        return button
    }()
    
    lazy var registerButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Se não possui uma conta, crie uma.", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        button.setTitleColor(.systemBlue, for: .normal)
        button.addTarget(self, action: #selector(tappedRegisterButton), for: .touchUpInside)
        return button
    }()
    
    @objc func tappedLoginButton() {
        delegate?.tappedLoginButton()
    }
    
    @objc func tappedRegisterButton() {
        delegate?.tappedRegisterButton()
    }
    
    init() {
        super.init(frame: .zero)
        backgroundColor = .black
        addElements()
        configConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addElements() {
        addSubview(headerView)
        addSubview(subTitleLabel)
        addSubview(emailTextField)
        addSubview(passwordTextField)
        addSubview(recoverPasswordButton)
        addSubview(loginButton)
        addSubview(registerButton)
    }
    func configConstraints() {
        NSLayoutConstraint.activate([
            
            
            headerView.topAnchor.constraint(equalTo: topAnchor),
            headerView.leadingAnchor.constraint(equalTo: leadingAnchor),
            headerView.trailingAnchor.constraint(equalTo: trailingAnchor),
            headerView.heightAnchor.constraint(equalToConstant: 150),
            
            subTitleLabel.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: 10),
            subTitleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            subTitleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            
            emailTextField.topAnchor.constraint(equalTo: subTitleLabel.bottomAnchor, constant: 20),
            emailTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            emailTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            emailTextField.heightAnchor.constraint(equalToConstant: 40),
            
            passwordTextField.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 20),
            passwordTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            passwordTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            passwordTextField.heightAnchor.constraint(equalToConstant: 40),
            
            recoverPasswordButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 10),
            recoverPasswordButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            recoverPasswordButton.heightAnchor.constraint(equalToConstant: 30),
            
            loginButton.bottomAnchor.constraint(equalTo: registerButton.topAnchor, constant: -10),
            loginButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            loginButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            loginButton.heightAnchor.constraint(equalToConstant: 40),
            
            registerButton.topAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -50),
            registerButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            registerButton.heightAnchor.constraint(equalToConstant: 40),
        ])
    }
    
    
    
}


