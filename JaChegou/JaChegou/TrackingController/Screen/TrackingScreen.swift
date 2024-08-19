//
//  TrackingScreen.swift
//  JaChegou
//
//  Created by MacBook on 11/08/24.
//

import UIKit
import Foundation

class TrackingScreen: UIView {
    
    lazy var headerView: HeaderView = {
        let view = HeaderView(title: "Cadastre Código Correios", image: UIImage(named: "worldImage"))
        view.translatesAutoresizingMaskIntoConstraints = false
        view.titleLabel.font = UIFont.boldSystemFont(ofSize: 35)
        return view
    }()
    
    lazy var subTitleLabelTrackingScreen: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .gray
        label.font = UIFont.boldSystemFont(ofSize: 12)
        label.textAlignment = .left
        label.text = "Cadastre o código de correios para ser rastreado"
        return label
    }()
    
    lazy var trackingCodeTextField: UITextField = {
        let tf = UITextField()
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.backgroundColor = UIColor.lightGray
        tf.placeholder = "Código de rastreio"
        tf.borderStyle = .roundedRect
//        tf.layer.cornerRadius = 10
        tf.clearButtonMode = .whileEditing
        return tf
    }()
    
    
    
    lazy var orderDescriptionTextField: UITextField = {
        let tf = UITextField()
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.placeholder = "Descrição* Ex.: Sapatos"
        tf.backgroundColor = UIColor.lightGray
        tf.borderStyle = .roundedRect
        return tf
    }()
    
    lazy var saveButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("SALVAR", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .systemBlue
        button.clipsToBounds = true
        button.layer.cornerRadius = 8
        button.addTarget(self, action: #selector(tappedSaveButton), for: .touchUpInside)
        return button
    }()
    
    @objc func tappedSaveButton() {
        print(#function)
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
        addSubview(subTitleLabelTrackingScreen)
        addSubview(trackingCodeTextField)
        addSubview(orderDescriptionTextField)
        addSubview(saveButton)
        
    }
    
    func configConstraints() {
        NSLayoutConstraint.activate([
            
            headerView.topAnchor.constraint(equalTo: topAnchor),
            headerView.leadingAnchor.constraint(equalTo: leadingAnchor),
            headerView.trailingAnchor.constraint(equalTo: trailingAnchor),
            headerView.heightAnchor.constraint(equalToConstant: 200),
            
            subTitleLabelTrackingScreen.topAnchor.constraint(equalTo: headerView.topAnchor, constant: 210),
            subTitleLabelTrackingScreen.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            subTitleLabelTrackingScreen.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            subTitleLabelTrackingScreen.heightAnchor.constraint(equalToConstant: 20),
            
            trackingCodeTextField.topAnchor.constraint(equalTo: subTitleLabelTrackingScreen.bottomAnchor, constant: 10),
            trackingCodeTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            trackingCodeTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            trackingCodeTextField.heightAnchor.constraint(equalToConstant: 40),
            
            orderDescriptionTextField.topAnchor.constraint(equalTo: trackingCodeTextField.bottomAnchor, constant: 20),
            orderDescriptionTextField.leadingAnchor.constraint(equalTo: trackingCodeTextField.leadingAnchor),
            orderDescriptionTextField.trailingAnchor.constraint(equalTo: trackingCodeTextField.trailingAnchor),
            orderDescriptionTextField.heightAnchor.constraint(equalTo: trackingCodeTextField.heightAnchor),
            
            saveButton.topAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -80),
            saveButton.leadingAnchor.constraint(equalTo: trackingCodeTextField.leadingAnchor),
            saveButton.trailingAnchor.constraint(equalTo: trackingCodeTextField.trailingAnchor),
            saveButton.heightAnchor.constraint(equalTo: trackingCodeTextField.heightAnchor),
            
        ])
    }
    
}
