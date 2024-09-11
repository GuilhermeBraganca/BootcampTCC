//
//  EmptyTrackingCollectionViewCell.swift
//  JaChegou
//
//  Created by MacBook on 08/09/24.
//

import UIKit

class EmptyTrackingCollectionViewCell: UICollectionViewCell {
    
    static let identifier: String = String(describing: EmptyTrackingCollectionViewCell.self)
    
    lazy var backGroundView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.borderColor = UIColor.white.cgColor
        view.layer.borderWidth = 2
        view.layer.cornerRadius = 8
        view.clipsToBounds = true
        return view
    }()
    
    lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 22)
        label.numberOfLines = 0
        label.text = "Adicione um novo Rastreio! Clique Aqui"
        label.textAlignment = .center
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addElements()
        configConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

func addElements() {
    contentView.addSubview(backGroundView)
    backGroundView.addSubview(descriptionLabel)
}

func configConstraints() {
    NSLayoutConstraint.activate([
        backGroundView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
        backGroundView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
        backGroundView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
        backGroundView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
        
        descriptionLabel.topAnchor.constraint(equalTo: backGroundView.topAnchor, constant: 40),
        descriptionLabel.leadingAnchor.constraint(equalTo: backGroundView.leadingAnchor, constant: 20),
        descriptionLabel.trailingAnchor.constraint(equalTo: backGroundView.trailingAnchor, constant: -20),
        descriptionLabel.bottomAnchor.constraint(equalTo: backGroundView.bottomAnchor, constant: -40)
    ])
}

}
