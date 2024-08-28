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
        return view
    }()
    
    lazy var subTitleLabelTrackingScreen: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor(hex: "#858585")
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
        tf.backgroundColor = UIColor(hex: "#858585")
        tf.borderStyle = .roundedRect
//        tf.layer.cornerRadius = 10
        tf.clearButtonMode = .whileEditing
        return tf
    }()
    
    
    
    lazy var orderDescriptionTextField: UITextField = {
        let tf = UITextField()
        let placeholderText =  "Descrição* Ex.: Sapatos"
        let attributes: [NSAttributedString.Key: Any] = [.foregroundColor: UIColor.white]
        tf.attributedPlaceholder = NSAttributedString(string: placeholderText, attributes: attributes)
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.backgroundColor = UIColor(hex: "#858585")
        tf.borderStyle = .roundedRect
//        tf.layer.cornerRadius = 10
        tf.clearButtonMode = .whileEditing
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
        button.addTarget(self, action: #selector(tappedDeleteNotificationButton), for: .touchUpInside)
        return button
    }()
    
    @objc func tappedDeleteNotificationButton() {
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

//extensão de cores conforme a ferramenta FIGMA
extension UIColor {
    convenience init(hex: String, alpha: CGFloat = 1.0) {
        var hexFormatted: String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()

        if hexFormatted.hasPrefix("#") {
            hexFormatted.remove(at: hexFormatted.startIndex)
        }

        assert(hexFormatted.count == 6, "Formato hexadecimal inválido")

        var rgbValue: UInt64 = 0
        Scanner(string: hexFormatted).scanHexInt64(&rgbValue)

        let red = CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0
        let green = CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0
        let blue = CGFloat(rgbValue & 0x0000FF) / 255.0

        self.init(red: red, green: green, blue: blue, alpha: alpha)
    }
}
