//
//  ProductTableViewCell.swift
//  JaChegou
//
//  Created by Fabio Cristiano Lopes on 19/08/24.
//

import Foundation
import UIKit

protocol ProductTableViewCellProtocol: AnyObject {
    func tappedDeleteProduct(track: Track?)
}

class ProductTableViewCell: UITableViewCell {
    
    static var identifier = String(describing: ProductTableViewCell.self)
    var track: Track?
    weak var delegate: ProductTableViewCellProtocol?
    
    
    lazy var productImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.backgroundColor = .customLightGray
        imageView.layer.cornerRadius = 8
        return imageView
    }()
    lazy var trackingNumberLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.numberOfLines = 2
        label.textColor = .white
        label.text = "Descrição:"
        label.textAlignment = .left
        label.setContentCompressionResistancePriority(.defaultHigh, for: .horizontal)
        
        return label
    }()
    lazy var eventLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.numberOfLines = 2
        label.textColor = .white
        label.text = "Evento:"
        label.textAlignment = .left
        label.setContentCompressionResistancePriority(.defaultHigh, for: .horizontal)
        
        return label
    }()
    lazy var cityLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.numberOfLines = 2
        label.textColor = .white
        label.text = "Cidade:"
        label.textAlignment = .left
        label.setContentCompressionResistancePriority(.defaultHigh, for: .horizontal)
        
        return label
    }()
    lazy var descriptionTrackingLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.numberOfLines = 2
        label.textColor = .white
        label.text = ""
        label.textAlignment = .left
        label.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        return label
    }()
    lazy var descriptionCityLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.numberOfLines = 2
        label.textColor = .white
        label.text = ""
        label.textAlignment = .left
        label.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        return label
    }()
    lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.text = "Data:    "
        label.textColor = .white
        label.textAlignment = .left
        return label
    }()
    
    lazy var descriptionEventLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 12)
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        label.textColor = .white
        label.textAlignment = .left
        label.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        return label
    }()
    
    lazy var descriptionDateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = .white
        label.numberOfLines = 0
        label.textAlignment = .left
        return label
    }()
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .customGray
        selectionStyle = .none
        addElements()
        configConstraints()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addElements() {
        contentView.addSubview(productImageView)
        contentView.addSubview(trackingNumberLabel)
        contentView.addSubview(eventLabel)
        contentView.addSubview(dateLabel)
        contentView.addSubview(cityLabel)
        contentView.addSubview(descriptionEventLabel)
        contentView.addSubview(descriptionTrackingLabel)
        contentView.addSubview(descriptionDateLabel)
        contentView.addSubview(descriptionCityLabel)
        
    }
    
    func configConstraints() {
        NSLayoutConstraint.activate([
            
            productImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
            productImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            productImageView.heightAnchor.constraint(equalToConstant: 36),
            productImageView.widthAnchor.constraint(equalToConstant: 36),
            
            trackingNumberLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
            trackingNumberLabel.leadingAnchor.constraint(equalTo: productImageView.trailingAnchor, constant: 20),
            
            descriptionTrackingLabel.centerYAnchor.constraint(equalTo: trackingNumberLabel.centerYAnchor),
            descriptionTrackingLabel.leadingAnchor.constraint(equalTo: trackingNumberLabel.trailingAnchor, constant: 5),
            descriptionTrackingLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            
            eventLabel.topAnchor.constraint(equalTo: trackingNumberLabel.bottomAnchor, constant: 0),
            eventLabel.leadingAnchor.constraint(equalTo: productImageView.trailingAnchor, constant: 20),
            
            descriptionEventLabel.centerYAnchor.constraint(equalTo: eventLabel.centerYAnchor),
            descriptionEventLabel.leadingAnchor.constraint(equalTo: eventLabel.trailingAnchor, constant: 5),
            descriptionEventLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            
            dateLabel.topAnchor.constraint(equalTo: descriptionEventLabel.bottomAnchor, constant: 0),
            dateLabel.leadingAnchor.constraint(equalTo: productImageView.trailingAnchor, constant: 20),
            
            descriptionDateLabel.centerYAnchor.constraint(equalTo: dateLabel.centerYAnchor),
            descriptionDateLabel.leadingAnchor.constraint(equalTo: dateLabel.trailingAnchor, constant: 5),
            descriptionDateLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            
            cityLabel.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: 0),
            cityLabel.leadingAnchor.constraint(equalTo: productImageView.trailingAnchor, constant: 20),
            
            descriptionCityLabel.centerYAnchor.constraint(equalTo: cityLabel.centerYAnchor),
            descriptionCityLabel.leadingAnchor.constraint(equalTo: cityLabel.trailingAnchor, constant: 5),
            descriptionCityLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            
            descriptionCityLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10)
        ])
        
    }
    
    func setupCell(track: Track, event: Events) {
        // Configura a célula com os dados do Track
        
        descriptionTrackingLabel.text = track.description
        descriptionEventLabel.text = event.descricao?.trimLeft() ?? ""
        descriptionDateLabel.text = event.data?.trimLeft() ?? ""
        descriptionCityLabel.text = event.cidade?.trimLeft() ?? ""
        productImageView.image = UIImage(systemName: "truck.box.fill")
    }
}
