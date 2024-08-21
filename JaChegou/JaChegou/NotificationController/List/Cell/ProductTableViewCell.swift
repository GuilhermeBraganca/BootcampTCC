//
//  ProductTableViewCell.swift
//  JaChegou
//
//  Created by Fabio Cristiano Lopes on 19/08/24.
//

import Foundation
import UIKit

protocol ProductTableViewCellProtocol: AnyObject {
  func tappedDeleteProduct(product: Product?)
}

class ProductTableViewCell: UITableViewCell {

  static var identifier = String(describing: ProductTableViewCell.self)
  var product: Product?
  weak var delegate: ProductTableViewCellProtocol?

  lazy var productImageView: UIImageView = {
    let imageView = UIImageView()
    imageView.translatesAutoresizingMaskIntoConstraints = false
      imageView.backgroundColor = .lightGray
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

  @objc func tappedDeleteButton() {
    delegate?.tappedDeleteProduct(product: product)
  }

  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
      backgroundColor = .darkGray
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
        productImageView.heightAnchor.constraint(equalToConstant: 72),
        productImageView.widthAnchor.constraint(equalToConstant: 62),

        productLabel.topAnchor.constraint(equalTo: productImageView.topAnchor),
        productLabel.leadingAnchor.constraint(equalTo: productImageView.trailingAnchor, constant: 20),
        productLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),

        codeProductLabel.topAnchor.constraint(equalTo: productLabel.bottomAnchor, constant: 5),
        codeProductLabel.leadingAnchor.constraint(equalTo: productLabel.leadingAnchor),
        codeProductLabel.trailingAnchor.constraint(equalTo: productLabel.trailingAnchor),

        eventProductLabel.topAnchor.constraint(equalTo: codeProductLabel.bottomAnchor, constant: 5),
        eventProductLabel.leadingAnchor.constraint(equalTo: productLabel.leadingAnchor),
        eventProductLabel.trailingAnchor.constraint(equalTo: productLabel.trailingAnchor),
        eventProductLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10)

    ])
  }

  func setupCell(product: Product) {
    self.product = product
      productLabel.text = "\(product.name)"
      productImageView.image = UIImage(systemName: product.image)
      codeProductLabel.text = "Código: \(product.codeProduct)"
      eventProductLabel.text = "Evento: \(product.eventProduct)"
  }
}

