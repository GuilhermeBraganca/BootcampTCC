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
        contentView.addSubview(eventLabel)
        contentView.addSubview(dateLabel)
        contentView.addSubview(cityLabel)
        contentView.addSubview(descriptionEventLabel)
        contentView.addSubview(descriptionDateLabel)
        contentView.addSubview(descriptionCityLabel)
        
    }
    
    func configConstraints() {
        NSLayoutConstraint.activate([
                eventLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
                eventLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
                
                descriptionEventLabel.centerYAnchor.constraint(equalTo: eventLabel.centerYAnchor),
                descriptionEventLabel.leadingAnchor.constraint(equalTo: eventLabel.trailingAnchor, constant: 10),
                descriptionEventLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
                
                dateLabel.topAnchor.constraint(equalTo: eventLabel.bottomAnchor, constant: 10),
                dateLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),

                descriptionDateLabel.centerYAnchor.constraint(equalTo: dateLabel.centerYAnchor),
                descriptionDateLabel.leadingAnchor.constraint(equalTo: dateLabel.trailingAnchor, constant: 10),
                descriptionDateLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
                
                cityLabel.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: 10),
                cityLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
                
                descriptionCityLabel.centerYAnchor.constraint(equalTo: cityLabel.centerYAnchor),
                descriptionCityLabel.leadingAnchor.constraint(equalTo: cityLabel.trailingAnchor, constant: 10),
                descriptionCityLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
                
                // descriptionDateLabel limita o contentView.bottomAnchor
                descriptionCityLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10)
            ])
        }
    
    func setupCell(events: Events) {
        
        descriptionEventLabel.text = events.descricao?.trimLeft() ?? ""
        descriptionDateLabel.text = events.data?.trimLeft() ?? ""
        descriptionCityLabel.text = events.cidade?.trimLeft() ?? ""
        
    }
}

extension String {
    func trimLeft() -> String {
        guard let range = rangeOfCharacter(from: .whitespacesAndNewlines.inverted) else {
            return ""
        }
        return String(self[range.lowerBound...])
    }
}
