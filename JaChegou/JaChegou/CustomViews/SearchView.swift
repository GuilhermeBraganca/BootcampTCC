//
//  SearchView.swift
//  JaChegou
//
//  Created by MacBook on 13/08/24.
//

import Foundation
import UIKit

class SearchBarView: UIView {

  lazy var searchIconImageView: UIImageView = {
    let imageView = UIImageView()
    imageView.translatesAutoresizingMaskIntoConstraints = false
    imageView.image = UIImage(systemName: "magnifyingglass")
    imageView.tintColor = .systemBlue
    return imageView
  }()

  lazy var searchLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.textColor = .black
    label.font = UIFont.systemFont(ofSize: 17)
    label.text = "Pesquisar pelo nome do produto"
    return label
  }()

  init() {
    super.init(frame: .zero)
      backgroundColor = .lightGray
    addElements()
    configConstraints()
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  func addElements() {
    addSubview(searchIconImageView)
    addSubview(searchLabel)
  }

  func configConstraints() {
    NSLayoutConstraint.activate([
      searchIconImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12),
      searchIconImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
      searchIconImageView.heightAnchor.constraint(equalToConstant: 24),
      searchIconImageView.widthAnchor.constraint(equalToConstant: 24),

      searchLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12),
      searchLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
      searchLabel.topAnchor.constraint(equalTo: topAnchor, constant: 12),
    ])
  }

}
