//
//  LoadingShared.swift
//  ImplementandoFirebase
//
//  Created by Caio Fabrini on 26/08/24.
//

import Foundation
import UIKit

final class LoadingShared: UIView {

  static let shared = LoadingShared()

  lazy var activityIndicatorView: UIActivityIndicatorView = {
   let loading = UIActivityIndicatorView()
    loading.translatesAutoresizingMaskIntoConstraints = false
    loading.color = .white
    loading.style = .large
    loading.backgroundColor = .black
    loading.clipsToBounds = true
    loading.layer.cornerRadius = 10
    return loading
  }()

  lazy var messageLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.textColor = .black
    label.font = UIFont.boldSystemFont(ofSize: 16)
    label.textAlignment = .center
    label.numberOfLines = 0
    return label
  }()

  private init() {
    super.init(frame: UIScreen.main.bounds)
    backgroundColor = .black.withAlphaComponent(0.5)
    addElements()
    configConstraints()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  func addElements() {
    addSubview(activityIndicatorView)
    addSubview(messageLabel)
  }

  func configConstraints() {
    NSLayoutConstraint.activate([
      activityIndicatorView.centerXAnchor.constraint(equalTo: centerXAnchor),
      activityIndicatorView.centerYAnchor.constraint(equalTo: centerYAnchor),
      activityIndicatorView.heightAnchor.constraint(equalToConstant: 70),
      activityIndicatorView.widthAnchor.constraint(equalToConstant: 70),

      messageLabel.topAnchor.constraint(equalTo: activityIndicatorView.bottomAnchor, constant: 20),
      messageLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
      messageLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
    ])
  }

  func start(message: String = "") {
    guard superview == nil else { return }

    guard let window = UIApplication.shared.connectedScenes.compactMap({$0 as? UIWindowScene}).first(where: {$0.activationState == .foregroundActive})?.windows.first(where: {$0.isKeyWindow}) else { return }
    window.addSubview(self)
    messageLabel.text = message
    messageLabel.isHidden = message.isEmpty
    activityIndicatorView.startAnimating()
  }

  func stop() {
    activityIndicatorView.stopAnimating()
    removeFromSuperview()
  }
}
