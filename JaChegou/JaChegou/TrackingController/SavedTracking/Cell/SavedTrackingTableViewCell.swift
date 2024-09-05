//
//  SavedTrackingTableViewCell.swift
//  JaChegou
//
//  Created by MacBook on 04/09/24.
//

import UIKit

import UIKit

protocol SavedTrackingTableViewCellProtocol: AnyObject {
    func tappedDeleteNotification(product: Product?)
}

class SavedTrackingTableViewCell: UITableViewCell {
    
    static var identifier = String(describing: SavedTrackingTableViewCell.self)
    var track: Track?
    weak var delegate: ProductTableViewCellProtocol?
    
    
    lazy var productImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.backgroundColor = .customLightGray
        imageView.layer.cornerRadius = 8
        return imageView
    }()
    
    lazy var productLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.numberOfLines = 2
        label.textColor = .white
        label.textAlignment = .left
        return label
    }()
    
    lazy var codeProductLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 12)
        label.textColor = .white
        label.textAlignment = .left
        return label
    }()
    
    lazy var eventProductLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 12)
        label.textColor = .white
        label.numberOfLines = 2
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
        contentView.addSubview(productLabel)
        contentView.addSubview(productImageView)
        contentView.addSubview(codeProductLabel)
        contentView.addSubview(eventProductLabel)
    }
    
    func configConstraints() {
        NSLayoutConstraint.activate([
            
            productImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            productImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            productImageView.heightAnchor.constraint(equalToConstant: 36),
            productImageView.widthAnchor.constraint(equalToConstant: 36),
            
            productLabel.topAnchor.constraint(equalTo: productImageView.topAnchor, constant: -10),
            productLabel.leadingAnchor.constraint(equalTo: productImageView.trailingAnchor, constant: 20),
            productLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            
            codeProductLabel.topAnchor.constraint(equalTo: productLabel.bottomAnchor, constant: 1),
            codeProductLabel.leadingAnchor.constraint(equalTo: productLabel.leadingAnchor),
            codeProductLabel.trailingAnchor.constraint(equalTo: productLabel.trailingAnchor),
            
            eventProductLabel.topAnchor.constraint(equalTo: codeProductLabel.bottomAnchor),
            eventProductLabel.leadingAnchor.constraint(equalTo: codeProductLabel.leadingAnchor),
            eventProductLabel.trailingAnchor.constraint(equalTo: codeProductLabel.trailingAnchor),
            eventProductLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10)
            
        ])
        
    }
    
    func setupCell(track: Track) {
        self.track = track
        productLabel.text = "\(track.description)"
        productImageView.image = UIImage(systemName: track.image)
        codeProductLabel.text = "Código: \(track.events[0].event)"
        eventProductLabel.text = "Evento: \(track.events[0].date)"
        
    }
}
