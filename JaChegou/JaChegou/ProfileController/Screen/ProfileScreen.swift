//
//  ProfileScreen.swift
//  JaChegou
//
//  Created by MacBook on 11/08/24.
//

import UIKit

protocol ProfileScreenProtocol: AnyObject {
    
    func tappedOutOfAccountButton()
    func tappedDeleteAccountButton()
    func tappedEditButton()
    
}

class ProfileScreen: UIView {
    
    weak var delegate: ProfileScreenProtocol?
    
    lazy var headerView: HeaderView = {
        
        let view = HeaderView(title: "Perfil", image: UIImage(named: "worldImage"))
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var personalInformationLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Informações pessoais"
        label.font = UIFont.boldSystemFont(ofSize: 15)
        label.textColor = .white
        return label
    }()
    
    lazy var emailLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "E-mail"
        label.font = UIFont.boldSystemFont(ofSize: 15)
        label.textColor = .white
        return label
    }()
    
    lazy var emailImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(systemName: "at")
        imageView.tintColor =  .customLightBlue
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Nome"
        label.font = UIFont.boldSystemFont(ofSize: 15)
        label.textColor = .white
        return label
    }()
    
    lazy var nameImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(systemName: "person.circle.fill")
        imageView.tintColor =  .customLightBlue
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    lazy var birthDataLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Data de Nascimento"
        label.font = UIFont.boldSystemFont(ofSize: 13)
        label.textColor = .white
        return label
    }()
    
    lazy var birthDataImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(systemName: "calendar.badge.plus")
        imageView.tintColor = .customLightBlue
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    lazy var outOfAccountButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Sair da conta", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .systemBlue
        button.clipsToBounds = true
        button.addTarget(self, action: #selector(tappedOutOfAccountButton), for: .touchUpInside)
        button.setImage(UIImage(named: "return"), for: .normal)
        button.layer.cornerRadius = 8
        return button
    }()
    
    lazy var deleteAccountButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Excluir conta", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .systemBlue
        button.clipsToBounds = true
        button.addTarget(self, action: #selector(tappedDeleteAccountButton), for: .touchUpInside)
        button.layer.cornerRadius = 8
        return button
    }()
    
    lazy var editButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(systemName:"pencil"), for: .normal)
        button.setTitle("Editar", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        button.imageView?.tintColor = .customLightBlue
        button.setTitleColor(.customLightBlue, for: .normal)
        button.addTarget(self, action: #selector(tappedEditButton), for: .touchUpInside)
        return button
    }()
    
    lazy var emailTextField: UITextField = {
        let emailTextField = UITextField()
        let placeholderText =  "teste@teste.com.br"
        let attributes: [NSAttributedString.Key: Any] = [.foregroundColor: UIColor.white]
        emailTextField.attributedPlaceholder = NSAttributedString(string: placeholderText, attributes: attributes)
        emailTextField.translatesAutoresizingMaskIntoConstraints = false
        emailTextField.borderStyle = .roundedRect
        emailTextField.backgroundColor = .customGray
        emailTextField.textColor = .white
        emailTextField.layer.cornerRadius = 15
        emailTextField.keyboardType = .emailAddress
        return emailTextField
    }()
    
    lazy var nameTextField: UITextField = {
        let passwordTextField = UITextField()
        let placeholderText =  "Nome"
        let attributes: [NSAttributedString.Key: Any] = [.foregroundColor: UIColor.white]
        passwordTextField.attributedPlaceholder = NSAttributedString(string: placeholderText, attributes: attributes)
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        passwordTextField.borderStyle = .roundedRect
        passwordTextField.backgroundColor = .customGray
        passwordTextField.textColor = .white
        passwordTextField.layer.cornerRadius = 15
        passwordTextField.keyboardType = .emailAddress
        return passwordTextField
    }()
    
    lazy var birthDataTextField: UITextField = {
        let callendarTextField = UITextField()
        let placeholderText =  "00/00/0000"
        let attributes: [NSAttributedString.Key: Any] = [.foregroundColor: UIColor.white]
        callendarTextField.attributedPlaceholder = NSAttributedString(string: placeholderText, attributes: attributes)
        callendarTextField.translatesAutoresizingMaskIntoConstraints = false
        callendarTextField.borderStyle = .roundedRect
        callendarTextField.backgroundColor = .customGray
        callendarTextField.textColor = .white
        callendarTextField.layer.cornerRadius = 15
        return callendarTextField
    }()
    
    @objc func tappedOutOfAccountButton() {
        delegate?.tappedOutOfAccountButton()
    }
    
    @objc func tappedDeleteAccountButton() {
        delegate?.tappedDeleteAccountButton()
    }
    
    @objc func tappedEditButton() {
        delegate?.tappedEditButton()
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
        addSubview(personalInformationLabel)
        addSubview(emailImageView)
        addSubview(emailLabel)
        addSubview(nameImageView)
        addSubview(nameLabel)
        addSubview(birthDataImageView)
        addSubview(birthDataLabel)
        //addSubview(editButton)
        addSubview(outOfAccountButton)
        addSubview(deleteAccountButton)
        addSubview(emailTextField)
        addSubview(nameTextField)
        addSubview(birthDataTextField)
        
    }
    
    func configConstraints() {
        NSLayoutConstraint.activate([
            
            headerView.topAnchor.constraint(equalTo: topAnchor),
            headerView.leadingAnchor.constraint(equalTo: leadingAnchor),
            headerView.trailingAnchor.constraint(equalTo: trailingAnchor),
            headerView.heightAnchor.constraint(equalToConstant: 150),
            
            personalInformationLabel.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: 20),
            personalInformationLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            personalInformationLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            
            emailImageView.topAnchor.constraint(equalTo: personalInformationLabel.bottomAnchor, constant: 50),
            emailImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            emailImageView.heightAnchor.constraint(equalToConstant: 20),
            emailImageView.widthAnchor.constraint(equalToConstant: 20),
            
            emailLabel.topAnchor.constraint(equalTo: emailImageView.topAnchor),
            emailLabel.leadingAnchor.constraint(equalTo: emailImageView.leadingAnchor, constant: 30),
            
            nameImageView.topAnchor.constraint(equalTo: emailImageView.bottomAnchor, constant: 30),
            nameImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            nameImageView.heightAnchor.constraint(equalToConstant: 20),
            nameImageView.widthAnchor.constraint(equalToConstant: 20),
            
            nameLabel.topAnchor.constraint(equalTo: nameImageView.topAnchor),
            nameLabel.leadingAnchor.constraint(equalTo: nameImageView.leadingAnchor, constant: 30),
            
            birthDataImageView.topAnchor.constraint(equalTo: nameImageView.bottomAnchor, constant: 30),
            birthDataImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            birthDataImageView.heightAnchor.constraint(equalToConstant: 20),
            birthDataImageView.widthAnchor.constraint(equalToConstant: 20),
            
            birthDataLabel.topAnchor.constraint(equalTo: birthDataImageView.topAnchor),
            birthDataLabel.leadingAnchor.constraint(equalTo: birthDataImageView.leadingAnchor, constant: 30),
            
//            editButton.bottomAnchor.constraint(equalTo: outOfAccountButton.topAnchor, constant: -20),
//            editButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -40),
            
            outOfAccountButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -80),
            outOfAccountButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            outOfAccountButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            outOfAccountButton.heightAnchor.constraint(equalToConstant: 40),
            
            deleteAccountButton.topAnchor.constraint(equalTo: outOfAccountButton.bottomAnchor, constant: 12),
            deleteAccountButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            deleteAccountButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            deleteAccountButton.heightAnchor.constraint(equalToConstant: 40),
            
            emailTextField.topAnchor.constraint(equalTo: personalInformationLabel.bottomAnchor, constant: 50),
            emailTextField.leadingAnchor.constraint(equalTo: birthDataLabel.trailingAnchor, constant: -20),
            emailTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            emailTextField.heightAnchor.constraint(equalToConstant: 30),
            
            nameTextField.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 15),
            nameTextField.leadingAnchor.constraint(equalTo: birthDataLabel.trailingAnchor, constant: -20),
            nameTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            nameTextField.heightAnchor.constraint(equalToConstant: 30),
            
            birthDataTextField.topAnchor.constraint(equalTo: nameTextField.bottomAnchor, constant: 20),
            birthDataTextField.leadingAnchor.constraint(equalTo: birthDataLabel.trailingAnchor, constant: -20),
            birthDataTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            birthDataTextField.heightAnchor.constraint(equalToConstant: 30),
        ])
    }
}
