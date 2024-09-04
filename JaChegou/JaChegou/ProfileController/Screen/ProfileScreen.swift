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
    func tappededitButton()
    
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
        imageView.tintColor =  .customLightBlue()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    lazy var phoneLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Telefone"
        label.font = UIFont.boldSystemFont(ofSize: 15)
        label.textColor = .white
        return label
    }()
    
    lazy var phoneImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(systemName: "phone.fill")
        imageView.tintColor = .customLightBlue()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    lazy var callendarLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Data de Nascimento"
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.textColor = .white
        return label
    }()
    
    lazy var callendarImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(systemName: "calendar.badge.plus")
        imageView.tintColor = .customLightBlue()
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
        button.imageView?.tintColor = .customLightBlue()
        button.setTitleColor(.customLightBlue(), for: .normal)
        button.addTarget(self, action: #selector(tappedEditButton), for: .touchUpInside)
        return button
    }()
    
    @objc func tappedOutOfAccountButton() {
        delegate?.tappedOutOfAccountButton()
    }
    
    @objc func tappedDeleteAccountButton() {
        delegate?.tappedDeleteAccountButton()
    }
    @objc func tappedEditButton() {
        delegate?.tappededitButton()
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
        addSubview(phoneImageView)
        addSubview(phoneLabel)
        addSubview(callendarImageView)
        addSubview(callendarLabel)
        addSubview(editButton)
        addSubview(outOfAccountButton)
        addSubview(deleteAccountButton)
        
    }
    
    func configConstraints() {
        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: topAnchor),
            headerView.leadingAnchor.constraint(equalTo: leadingAnchor),
            headerView.trailingAnchor.constraint(equalTo: trailingAnchor),
            headerView.heightAnchor.constraint(equalToConstant: 200),
            
            personalInformationLabel.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: 20),
            personalInformationLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            personalInformationLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            
            emailImageView.topAnchor.constraint(equalTo: personalInformationLabel.bottomAnchor, constant: 50),
            emailImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            emailImageView.heightAnchor.constraint(equalToConstant: 20),
            emailImageView.widthAnchor.constraint(equalToConstant: 20),
            
            emailLabel.topAnchor.constraint(equalTo: emailImageView.topAnchor),
            emailLabel.leadingAnchor.constraint(equalTo: emailImageView.leadingAnchor, constant: 30),
            
            phoneImageView.topAnchor.constraint(equalTo: emailImageView.bottomAnchor, constant: 30),
            phoneImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            phoneImageView.heightAnchor.constraint(equalToConstant: 20),
            phoneImageView.widthAnchor.constraint(equalToConstant: 20),
            
            phoneLabel.topAnchor.constraint(equalTo: phoneImageView.topAnchor),
            phoneLabel.leadingAnchor.constraint(equalTo: phoneImageView.leadingAnchor, constant: 30),
            
            callendarImageView.topAnchor.constraint(equalTo: phoneImageView.bottomAnchor, constant: 30),
            callendarImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            callendarImageView.heightAnchor.constraint(equalToConstant: 20),
            callendarImageView.widthAnchor.constraint(equalToConstant: 20),
            
            callendarLabel.topAnchor.constraint(equalTo: callendarImageView.topAnchor),
            callendarLabel.leadingAnchor.constraint(equalTo: callendarImageView.leadingAnchor, constant: 30),
            
            editButton.bottomAnchor.constraint(equalTo: outOfAccountButton.topAnchor, constant: -20),
            editButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -40),
            
            outOfAccountButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -80),
            outOfAccountButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            outOfAccountButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            outOfAccountButton.heightAnchor.constraint(equalToConstant: 40),
            
            deleteAccountButton.topAnchor.constraint(equalTo: outOfAccountButton.bottomAnchor, constant: 12),
            deleteAccountButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            deleteAccountButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            deleteAccountButton.heightAnchor.constraint(equalToConstant: 40),
        ])
    }
}


