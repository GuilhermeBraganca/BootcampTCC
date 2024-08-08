import UIKit


protocol LoginScreenProtocol: AnyObject {
  func tappedLoginButton()
  func tappedRegisterButton()
}


class LoginScreen: UIView {

  weak var delegate: LoginScreenProtocol?
    
    
    lazy var logoImageView: UIImageView = {
      let imageView = UIImageView()
      imageView.translatesAutoresizingMaskIntoConstraints = false
      imageView.image = UIImage(named: "worldBackgroundImage")
      imageView.tintColor = .lightGray
      imageView.contentMode = .scaleAspectFit
      return imageView
    }()
  
    
  lazy var loginLabel: UILabel = {
    let label = UILabel()
    
    label.text = "Para aproveitar todos os recursos, faça login."
    label.numberOfLines = 2
    //label.lineBreakMode = .byWordWrapping
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
    tf.backgroundColor = UIColor(hex: "#272A2E")
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
      tf.backgroundColor = UIColor(hex: "#272A2E")
      tf.textColor = .white
      tf.layer.cornerRadius = 15
      tf.keyboardType = .emailAddress
    return tf
  }()

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
    addSubview(loginLabel)
    addSubview(subTitleLabel)
    addSubview(logoImageView)
    addSubview(emailTextField)
    addSubview(passwordTextField)
    addSubview(loginButton)
    addSubview(registerButton)
  }

  func configConstraints() {
    NSLayoutConstraint.activate([
      

      logoImageView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: -150),
    
      logoImageView.centerXAnchor.constraint(equalTo: centerXAnchor),
      logoImageView.heightAnchor.constraint(equalToConstant: 300),
      logoImageView.widthAnchor.constraint(equalToConstant: 400),
      
      loginLabel.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: 10),
      loginLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
      loginLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
      //loginLabel.heightAnchor.constraint(equalToConstant: 40),
      
      subTitleLabel.topAnchor.constraint(equalTo: loginLabel.bottomAnchor, constant: 10),
      subTitleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
      subTitleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
      //subTitleLabel.heightAnchor.constraint(equalToConstant: 40),
      
      emailTextField.topAnchor.constraint(equalTo: subTitleLabel.bottomAnchor, constant: 50),
      emailTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
      emailTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
      emailTextField.heightAnchor.constraint(equalToConstant: 40),

      passwordTextField.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 20),
      passwordTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
      passwordTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
      passwordTextField.heightAnchor.constraint(equalToConstant: 40),

      loginButton.bottomAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 250),
      loginButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
      loginButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
      loginButton.heightAnchor.constraint(equalToConstant: 40),
      
      registerButton.topAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -50),
      registerButton.centerXAnchor.constraint(equalTo: centerXAnchor),
      registerButton.heightAnchor.constraint(equalToConstant: 40),
    ])
  }

}

extension UIColor {
    convenience init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet(charactersIn: "#"))
        var rgbValue: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&rgbValue)
        
        let red = CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0
        let green = CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0
        let blue = CGFloat(rgbValue & 0x0000FF) / 255.0
        
        self.init(red: red, green: green, blue: blue, alpha: 1.0)
    }
}
