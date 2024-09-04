//
//  CreateAccountScreen.swift
//  JaChegou
//
//  Created by MacBook on 10/08/24.
//

import Foundation
import UIKit

protocol CreateAccountScreenProtocol: AnyObject {
    func tappedLoginButton()
    func tappedRegisterButton()
    func tappedEyePasswordButton()
    func tappedEyeConfirmPasswordButton()
}

class CreateAccountScreen: UIView {
    
    weak var delegate: CreateAccountScreenProtocol?
    
    lazy var headerView: HeaderView = {
      let view = HeaderView(title: "Para aproveitar todos os recursos, crie uma conta.", image: UIImage(named: "worldImage"))
      view.translatesAutoresizingMaskIntoConstraints = false
      return view
    }()
    
    
    lazy var createAccountLabel: UILabel = {
        let label = UILabel()
        
        label.text = "Para aproveitar todos os recursos, crie uma conta."
        label.numberOfLines = 2
        //label.lineBreakMode = .byWordWrapping
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 20)
        return label
    }()
    
    lazy var nameTextField: UITextField = {
        let tf = UITextField()
        let placeholderText =  "Nome completo*"
        let attributes: [NSAttributedString.Key: Any] = [.foregroundColor: UIColor.white]
        tf.attributedPlaceholder = NSAttributedString(string: placeholderText, attributes: attributes)
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.borderStyle = .roundedRect
        tf.backgroundColor = .customGray()
        tf.textColor = .white
        tf.layer.cornerRadius = 20
        return tf
    }()
    
    lazy var emailTextField: UITextField = {
        let tf = UITextField()
        let placeholderText =  "E-mail*"
        let attributes: [NSAttributedString.Key: Any] = [.foregroundColor: UIColor.white]
        tf.attributedPlaceholder = NSAttributedString(string: placeholderText, attributes: attributes)
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.borderStyle = .roundedRect
        tf.backgroundColor = .customGray()
        tf.textColor = .white
        tf.layer.cornerRadius = 20
        tf.keyboardType = .emailAddress
        return tf
    }()
    
    lazy var birthDateTextField: UITextField = {
        let tf = UITextField()
        let placeholderText =  "Data de nascimento*"
        let attributes: [NSAttributedString.Key: Any] = [.foregroundColor: UIColor.white]
        tf.attributedPlaceholder = NSAttributedString(string: placeholderText, attributes: attributes)
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.borderStyle = .roundedRect
        tf.backgroundColor = .customGray()
        tf.textColor = .white
        tf.layer.cornerRadius = 20
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
        tf.backgroundColor = .customGray()
        tf.textColor = .white
        tf.layer.cornerRadius = 20
        tf.keyboardType = .emailAddress
        return tf
    }()
    
    lazy var eyePasswordImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(systemName: "eye")
        imageView.tintColor = .lightGray
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    lazy var confirmPasswordTextField: UITextField = {
        let tf = UITextField()
        let placeholderText =  "Confirmar Senha*"
        let attributes: [NSAttributedString.Key: Any] = [.foregroundColor: UIColor.white]
        tf.attributedPlaceholder = NSAttributedString(string: placeholderText, attributes: attributes)
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.borderStyle = .roundedRect
        tf.isSecureTextEntry = true
        tf.backgroundColor = .customGray()
        tf.textColor = .white
        tf.layer.cornerRadius = 20
        tf.keyboardType = .emailAddress
        return tf
    }()
    lazy var eyeConfirmPasswordImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(systemName: "eye")
        imageView.tintColor = .lightGray
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    lazy var loginButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("CONFIRMAR", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .systemBlue
        button.clipsToBounds = true
        button.layer.cornerRadius = 20
        button.addTarget(self, action: #selector(tappedLoginButton), for: .touchUpInside)
        return button
    }()
    
    lazy var registerButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Se já possui uma conta, faça login.", for: .normal)
        
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
    @objc func tappedEyePasswordButton() {
        passwordTextField.isSecureTextEntry.toggle()
        let image = passwordTextField.isSecureTextEntry ? UIImage(systemName: "eye") : UIImage(systemName: "eye.slash")
        eyePasswordImageView.image = image
    }
    
    @objc func tappedEyeConfirmPasswordButton() {
        confirmPasswordTextField.isSecureTextEntry.toggle()
        let image = confirmPasswordTextField.isSecureTextEntry ? UIImage(systemName: "eye") : UIImage(systemName: "eye.slash")
        eyeConfirmPasswordImageView.image = image
    }
    
    init() {
        super.init(frame: .zero)
        backgroundColor = .black
        addElements()
        configConstraints()
        configEyeButtonGesture()
    }
    
    func configEyeButtonGesture() {
        let tapEyePassword: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(tappedEyePasswordButton))
        tapEyePassword.cancelsTouchesInView = false
        tapEyePassword.numberOfTapsRequired = 1
        eyePasswordImageView.isUserInteractionEnabled = true
        eyePasswordImageView.addGestureRecognizer(tapEyePassword)
        
        let tapEyeConfirmPassword: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(tappedEyeConfirmPasswordButton))
        tapEyeConfirmPassword.cancelsTouchesInView = false
        tapEyeConfirmPassword.numberOfTapsRequired = 1
        eyeConfirmPasswordImageView.isUserInteractionEnabled = true
        eyeConfirmPasswordImageView.addGestureRecognizer(tapEyeConfirmPassword)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addElements() {
        addSubview(headerView)
        //addSubview(createAccountLabel)
        addSubview(nameTextField)
        addSubview(emailTextField)
        addSubview(birthDateTextField)
        addSubview(passwordTextField)
        addSubview(eyePasswordImageView)
        addSubview(confirmPasswordTextField)
        addSubview(eyeConfirmPasswordImageView)
        addSubview(loginButton)
        addSubview(registerButton)
    }
    func configConstraints() {
        NSLayoutConstraint.activate([
            
            
            headerView.topAnchor.constraint(equalTo: topAnchor),
            headerView.leadingAnchor.constraint(equalTo: leadingAnchor),
            headerView.trailingAnchor.constraint(equalTo: trailingAnchor),
            headerView.heightAnchor.constraint(equalToConstant: 200),
            
//            createAccountLabel.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: 20),
//            createAccountLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
//            createAccountLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            
            
            nameTextField.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: 30),
            nameTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            nameTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            nameTextField.heightAnchor.constraint(equalToConstant: 40),
            
            emailTextField.topAnchor.constraint(equalTo: nameTextField.bottomAnchor, constant: 10),
            emailTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            emailTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            emailTextField.heightAnchor.constraint(equalToConstant: 40),
            
            birthDateTextField.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 10),
            birthDateTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            birthDateTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            birthDateTextField.heightAnchor.constraint(equalToConstant: 40),
            
            passwordTextField.topAnchor.constraint(equalTo: birthDateTextField.bottomAnchor, constant: 10),
            passwordTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            passwordTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            passwordTextField.heightAnchor.constraint(equalToConstant: 40),
            
            
            eyePasswordImageView.centerYAnchor.constraint(equalTo: passwordTextField.centerYAnchor),
            eyePasswordImageView.trailingAnchor.constraint(equalTo: passwordTextField.trailingAnchor, constant: -12),
            eyePasswordImageView.heightAnchor.constraint(equalToConstant: 30),
            eyePasswordImageView.widthAnchor.constraint(equalToConstant: 30),
            
            confirmPasswordTextField.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 10),
            confirmPasswordTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            confirmPasswordTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            confirmPasswordTextField.heightAnchor.constraint(equalToConstant: 40),
            
            eyeConfirmPasswordImageView.centerYAnchor.constraint(equalTo: confirmPasswordTextField.centerYAnchor),
            eyeConfirmPasswordImageView.trailingAnchor.constraint(equalTo: confirmPasswordTextField.trailingAnchor, constant: -12),
            eyeConfirmPasswordImageView.heightAnchor.constraint(equalToConstant: 30),
            eyeConfirmPasswordImageView.widthAnchor.constraint(equalToConstant: 30),
            
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

