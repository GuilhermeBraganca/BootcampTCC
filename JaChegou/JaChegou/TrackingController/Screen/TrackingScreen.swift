//
//  TrackingScreen.swift
//  JaChegou
//
//  Created by MacBook on 11/08/24.
//

import UIKit

protocol TrackingScreenProtocol: AnyObject {
   func tapped()
}

class TrackingScreen: UIView {

  weak var delegate: TrackingScreenProtocol?

    lazy var headerView: HeaderView = {
        let view = HeaderView(title: "Cadastre Código Correios", image: UIImage(named: "worldImage"))
        view.translatesAutoresizingMaskIntoConstraints = false
        view.contentMode = .scaleAspectFill
        return view
    }()
    
    lazy var subTitleLabelTrackingScreen: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .customLightGray
        label.font = UIFont.boldSystemFont(ofSize: 12)
        label.textAlignment = .left
        label.text = "Cadastre o código de correios para ser rastreado"
        return label
    }()
    
    lazy var trackingCodeTextField: UITextField = {
        let tf = UITextField()
        let placeholderText =  "Código de rastreio"
        let attributes: [NSAttributedString.Key: Any] = [.foregroundColor: UIColor.white]
        tf.attributedPlaceholder = NSAttributedString(string: placeholderText, attributes: attributes)
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.borderStyle = .roundedRect
        tf.backgroundColor = .customGray
        tf.textColor = .white
        tf.text = "NM455753071BR"
        tf.layer.cornerRadius = 20
        return tf
    }()
    
    lazy var orderDescriptionTextField: UITextField = {
        let tf = UITextField()
        let placeholderText =  "Descrição* Ex.: Sapatos"
        let attributes: [NSAttributedString.Key: Any] = [.foregroundColor: UIColor.white]
        tf.attributedPlaceholder = NSAttributedString(string: placeholderText, attributes: attributes)
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.borderStyle = .roundedRect
        tf.backgroundColor = .customGray
        tf.textColor = .white
        tf.layer.cornerRadius = 20
        return tf
    }()
    
    lazy var saveButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Salvar", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .systemBlue
        button.clipsToBounds = true
        button.layer.cornerRadius = 8
        button.addTarget(self, action: #selector(saveButtonTapped), for: .touchUpInside)
        return button
    }()
    
    @objc private func saveButtonTapped() {
      delegate?.tapped()
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
    
    private func addElements() {
        addSubview(headerView)
        addSubview(subTitleLabelTrackingScreen)
        addSubview(trackingCodeTextField)
        addSubview(orderDescriptionTextField)
        addSubview(saveButton)
    }
    
    private func configConstraints() {
        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: topAnchor),
            headerView.leadingAnchor.constraint(equalTo: leadingAnchor),
            headerView.trailingAnchor.constraint(equalTo: trailingAnchor),
            headerView.heightAnchor.constraint(equalToConstant: 150),
            
            subTitleLabelTrackingScreen.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: 10),
            subTitleLabelTrackingScreen.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            subTitleLabelTrackingScreen.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            subTitleLabelTrackingScreen.heightAnchor.constraint(equalToConstant: 10),
            
            trackingCodeTextField.topAnchor.constraint(equalTo: subTitleLabelTrackingScreen.bottomAnchor, constant: 15),
            trackingCodeTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            trackingCodeTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            trackingCodeTextField.heightAnchor.constraint(equalToConstant: 40),
            
            orderDescriptionTextField.topAnchor.constraint(equalTo: trackingCodeTextField.bottomAnchor, constant: 20),
            orderDescriptionTextField.leadingAnchor.constraint(equalTo: trackingCodeTextField.leadingAnchor),
            orderDescriptionTextField.trailingAnchor.constraint(equalTo: trackingCodeTextField.trailingAnchor),
            orderDescriptionTextField.heightAnchor.constraint(equalTo: trackingCodeTextField.heightAnchor),
            
            saveButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            saveButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            saveButton.heightAnchor.constraint(equalToConstant: 40),
            saveButton.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -40),
        ])
    }
}


