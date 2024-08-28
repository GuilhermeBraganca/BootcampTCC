//
//  HeaderView.swift
//  JaChegou
//
//  Created by MacBook on 12/08/24.
//
import Foundation
import UIKit

// Como criar um elemento customizável?
// Crie uma view apartada para o seu elemento
// Pense que o seu elemento ele é como se fosse uma label, um botão, um textField, etc...
// Esse elemento serve para que você possa REUTILIZA-LO EM QUALQUER LOCAL DO SEU APP!!
// Sendo assim, com ele você vai utiliza-lo como qualquer outro elemento
// Ex elementos básicos: lazy var nameTextField: UITextField
// Ex customizável     : lazy var headerView: HeaderView


class TrackingDetailsView: UIView {
    
    lazy var TrackingImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "TrackingImage")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    lazy var trackingLabel: UILabel = {
        let label = UILabel()
        label.text = "Nome ou Código"
        label.numberOfLines = 2
        //label.lineBreakMode = .byWordWrapping
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 18)
        return label
    }()
    
    lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.text = "20/10/2023"
        label.numberOfLines = 2
        //label.lineBreakMode = .byWordWrapping
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 18)
        return label
    }()
    
    init(tracking: String, date: String) {
        super.init(frame: .zero)
        backgroundColor = .red
        addElements()
        configConstraints()
        configElements(tracking: tracking, date: date)
    }
    
    func configElements(tracking: String, date: String ) {
        trackingLabel.text = tracking
        dateLabel.text = date
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addElements() {
        addSubview(TrackingImageView)
        addSubview(trackingLabel)
        addSubview(dateLabel)
    }
    
    func configConstraints() {
        NSLayoutConstraint.activate([
            TrackingImageView.topAnchor.constraint(equalTo: topAnchor),
            TrackingImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            TrackingImageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            TrackingImageView.heightAnchor.constraint(equalToConstant: 100),
            
            trackingLabel.topAnchor.constraint(equalTo: TrackingImageView.bottomAnchor, constant: 20),
            trackingLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            trackingLabel.centerYAnchor.constraint(equalTo: TrackingImageView.centerYAnchor),
            
            dateLabel.topAnchor.constraint(equalTo:  trackingLabel.bottomAnchor, constant: 20),
            dateLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            dateLabel.centerYAnchor.constraint(equalTo: TrackingImageView.centerYAnchor),
            
            
        ])
    }
}
