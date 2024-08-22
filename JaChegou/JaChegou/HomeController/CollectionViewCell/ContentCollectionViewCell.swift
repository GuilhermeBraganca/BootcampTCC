//
//  ContentCollectionViewCell.swift
//  JaChegou
//
//  Created by MacBook on 19/08/24.
//

import UIKit

class ContentCollectionViewCell: UICollectionViewCell {
    
    static let identifier: String = String(describing: ContentCollectionViewCell.self)
    static let heightCell: CGFloat = 800
    
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
        label.font = ContentCollectionViewCell.labelFont
        label.textAlignment = .center
        return label
    }()
    lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .gray
        label.font = ContentCollectionViewCell.labelFont
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
            itemImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 0),
            itemImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 0),
            itemImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 0),
            itemImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 0),
            
            
            descLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            descLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor, constant: 40),
            
            
            dateLabel.topAnchor.constraint(equalTo: descLabel.bottomAnchor),
            dateLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            dateLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            
        ])
    }
    
    func setupCell(item: Item) {
        descLabel.text = item.description
        dateLabel.text = item.date
        itemImageView.image = UIImage(named: item.image)
    }
    
    static func calculateSize(title: String) -> CGSize {
        let maxSize = CGSize(width: CGFloat.greatestFiniteMagnitude, height: heightCell)
        let boundingBox = (title as NSString).boundingRect(with: maxSize, options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: labelFont], context: nil)
        let widthLayer: CGFloat = 4 // esse valor é a soma das distancias das constraints laterais do elemento + 4 de gordura (8 + 8 == 16 + 4 de gordura)
        return CGSize(width: boundingBox.width + widthLayer, height: heightCell)
    }
}

