//
//  RecoverPasswordScreen.swift
//  JaChegou
//
//  Created by Fabio Cristiano Lopes on 08/09/24.
//

import UIKit
import Foundation

class RecoverPasswordScreen: UIView {
    
    lazy var headerView: HeaderView = {
        let view = HeaderView(title: "Recuperar Senha", image: UIImage(named: "worldImage"))
        view.translatesAutoresizingMaskIntoConstraints = false
        view.contentMode = .scaleAspectFill
        return view
    }()
    
    lazy var subTitleRecoverPassword: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .customLightGray
        label.font = UIFont.boldSystemFont(ofSize: 12)
        label.textAlignment = .left
        label.text = "Informe seu e-mail para recuperar a senha"
        return label
    }()
    
    lazy var recoverPasswordTextField: UITextField = {
        let tf = UITextField()
        let placeholderText =  "E-mail"
        let attributes: [NSAttributedString.Key: Any] = [.foregroundColor: UIColor.white]
        tf.attributedPlaceholder = NSAttributedString(string: placeholderText, attributes: attributes)
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.borderStyle = .roundedRect
        tf.backgroundColor = .customGray
        tf.textColor = .white
        tf.layer.cornerRadius = 20
        tf.keyboardType = .emailAddress
        return tf
    }()
    
    lazy var sendEmailButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Enviar", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 20
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(tappedSendEmailButton), for: .touchUpInside)
        return button
    }()
    
    @objc func tappedSendEmailButton() {
        guard let email = recoverPasswordTextField.text, !email.isEmpty else {
        // Campo e-mail vazio ou informado sem a formatação correta
            showAlert(title: "Erro", message: "Por favor, insira um e-mail válido.")
            return
        }
        // Envio do e-mail de recuperação
        showAlert(title: "Sucesso", message: "E-mail de recuperação enviado para \(email).")
    }
    
    func showAlert(title: String, message: String) {
        if let viewController = self.window?.rootViewController {
            let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            viewController.present(alert, animated: true, completion: nil)
        }
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
        addSubview(subTitleRecoverPassword)
        addSubview(recoverPasswordTextField)
        addSubview(sendEmailButton)
    }
    
    func configConstraints() {
        NSLayoutConstraint.activate([
            
            headerView.topAnchor.constraint(equalTo: topAnchor),
            headerView.leadingAnchor.constraint(equalTo: leadingAnchor),
            headerView.trailingAnchor.constraint(equalTo: trailingAnchor),
            headerView.heightAnchor.constraint(equalToConstant: 150),
            
            subTitleRecoverPassword.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: 10),
            subTitleRecoverPassword.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            subTitleRecoverPassword.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            subTitleRecoverPassword.heightAnchor.constraint(equalToConstant: 10),
            
            recoverPasswordTextField.topAnchor.constraint(equalTo: subTitleRecoverPassword.bottomAnchor, constant: 15),
            recoverPasswordTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            recoverPasswordTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            recoverPasswordTextField.heightAnchor.constraint(equalToConstant: 40),
            
            sendEmailButton.topAnchor.constraint(equalTo: recoverPasswordTextField.bottomAnchor, constant: 20),
            sendEmailButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            sendEmailButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            sendEmailButton.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
}
