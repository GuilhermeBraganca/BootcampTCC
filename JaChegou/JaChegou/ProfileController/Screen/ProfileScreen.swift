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
        return label
    }()
    
    lazy var emailImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(systemName: "at")
        imageView.tintColor = .systemBlue
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    lazy var phoneImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(systemName: "phone.fill")
        imageView.tintColor = .systemBlue
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    lazy var callendarImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(systemName: "calendar.badge.plus")
        imageView.tintColor = .systemBlue
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    lazy var outOfAccountButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("SAIR DA CONTA", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .gray
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
        button.backgroundColor = .gray
        button.clipsToBounds = true
        button.addTarget(self, action: #selector(tappedDeleteAccountButton), for: .touchUpInside)
        button.layer.cornerRadius = 8
        return button
    }()
    
    @objc func tappedOutOfAccountButton() {
        delegate?.tappedOutOfAccountButton()
        
    }
    
    @objc func tappedDeleteAccountButton() {
        delegate?.tappedDeleteAccountButton()
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
        addSubview(phoneImageView)
        addSubview(callendarImageView)
        addSubview(outOfAccountButton)
        addSubview(deleteAccountButton)
        
    }
    
    func configConstraints() {
        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: topAnchor),
            headerView.leadingAnchor.constraint(equalTo: leadingAnchor),
            headerView.trailingAnchor.constraint(equalTo: trailingAnchor),
            headerView.heightAnchor.constraint(equalToConstant: 200),
            
            personalInformationLabel.topAnchor.constraint(equalTo: topAnchor, constant: 230),
            personalInformationLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            personalInformationLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            
            emailImageView.topAnchor.constraint(equalTo: personalInformationLabel.bottomAnchor, constant: 50),
            emailImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            emailImageView.heightAnchor.constraint(equalToConstant: 20),
            emailImageView.widthAnchor.constraint(equalToConstant: 20),
            
            phoneImageView.topAnchor.constraint(equalTo: emailImageView.bottomAnchor, constant: 30),
            phoneImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            phoneImageView.heightAnchor.constraint(equalToConstant: 20),
            phoneImageView.widthAnchor.constraint(equalToConstant: 20),
            
            callendarImageView.topAnchor.constraint(equalTo: phoneImageView.bottomAnchor, constant: 30),
            callendarImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            callendarImageView.heightAnchor.constraint(equalToConstant: 20),
            callendarImageView.widthAnchor.constraint(equalToConstant: 20),
            
            outOfAccountButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -70),
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


