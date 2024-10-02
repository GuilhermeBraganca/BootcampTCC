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
    //var track: Track?
    weak var delegate: SavedTrackingTableViewCellProtocol?
    
    
    lazy var eventLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.numberOfLines = 2
        label.textColor = .white
        label.text = "Evento:"
        label.textAlignment = .left
        return label
    }()
    lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.text = "Data:"
        label.textColor = .white
        label.textAlignment = .left
        return label
    }()
    
    lazy var descriptionEventLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 12)
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 2
        label.textColor = .white
        label.textAlignment = .left
        return label
    }()
    
    lazy var descriptionDateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 12)
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
        contentView.addSubview(eventLabel)
        contentView.addSubview(descriptionEventLabel)
        contentView.addSubview(dateLabel)
        contentView.addSubview(descriptionDateLabel)
        
    }
    
    func configConstraints() {
        NSLayoutConstraint.activate([
            
            eventLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            eventLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),

            // Posiciona descriptionEventLabel na mesma linha, mas assegura que não sobreponha o eventLabel
            descriptionEventLabel.centerYAnchor.constraint(equalTo: eventLabel.centerYAnchor), // Alinha verticalmente com eventLabel
            descriptionEventLabel.leadingAnchor.constraint(equalTo: eventLabel.trailingAnchor, constant: 10),
            descriptionEventLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),

            // Posiciona o dateLabel abaixo do eventLabel
            dateLabel.topAnchor.constraint(equalTo: eventLabel.bottomAnchor, constant: 10),
            dateLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            dateLabel.bottomAnchor.constraint(lessThanOrEqualTo: contentView.bottomAnchor, constant: -10),

            // Posiciona descriptionDateLabel alinhado com dateLabel e respeita o contentView.bottomAnchor
            descriptionDateLabel.topAnchor.constraint(equalTo: dateLabel.topAnchor),
            descriptionDateLabel.leadingAnchor.constraint(equalTo: descriptionEventLabel.leadingAnchor),
            descriptionDateLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            descriptionDateLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10)
        ])
        
    }
    
    func setupCell(events: TrackingInfoResponse) {
        
        descriptionEventLabel.text = "\(events.descricao ?? "")"
        descriptionDateLabel.text = "\(events.data ?? "")"
        
    }
}
