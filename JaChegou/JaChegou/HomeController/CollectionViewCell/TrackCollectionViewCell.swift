//
//  ContentCollectionViewCell.swift
//  JaChegou
//
//  Created by MacBook on 19/08/24.
//

import UIKit

class TrackCollectionViewCell: UICollectionViewCell {
    
    static let identifier: String = String(describing: TrackCollectionViewCell.self)
    static let heightCell: CGFloat = 400
    
    private static var labelFont = UIFont.boldSystemFont(ofSize: 16)
    
    lazy var itemImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    lazy var descLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.font = TrackCollectionViewCell.labelFont
        label.textAlignment = .center
        return label
    }()
    lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .gray
        label.font = TrackCollectionViewCell.labelFont
        label.textAlignment = .center
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .black
        addElements()
        configConstraints()
        setupBorder()
    }
    private func setupBorder() {
        contentView.layer.borderColor = UIColor.lightGray.cgColor // Cor da borda
        contentView.layer.borderWidth = 2.0 // Espessura da borda
        contentView.layer.cornerRadius = 10.0 // Raio dos cantos (opcional)
        contentView.layer.masksToBounds = true // Garante que o conteúdo fique dentro da borda
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addElements() {
        contentView.addSubview(itemImageView)
        contentView.addSubview(descLabel)
        contentView.addSubview(dateLabel)
    }
    
    func configConstraints() {
        NSLayoutConstraint.activate([
            itemImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            itemImageView.heightAnchor.constraint(equalToConstant: 96),
            itemImageView.widthAnchor.constraint(equalToConstant: 96),
            itemImageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            
            descLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            descLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor, constant: 50),
            
            dateLabel.topAnchor.constraint(equalTo: descLabel.bottomAnchor),
            dateLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            dateLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            
        ])
    }
    
    func setupCell(item: Track) {
        descLabel.text = item.description
        dateLabel.text = item.date
        itemImageView.image = UIImage(named: item.image)
    }

}

