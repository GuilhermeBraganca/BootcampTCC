//
//  Loading.swift
//  ImplementandoFirebase
//
//  Created by Caio Fabrini on 20/08/24.
//

import Foundation
import UIKit

class Loading {

  var viewController: UIViewController

  init(viewController: UIViewController) {
    self.viewController = viewController
  }

  lazy var containerView: UIView = {
    let view = UIView()
    view.translatesAutoresizingMaskIntoConstraints = false
    view.backgroundColor = .black.withAlphaComponent(0.5)
    return view
  }()

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

  func addElements() {
    containerView.addSubview(activityIndicatorView)
    containerView.addSubview(messageLabel)
    viewController.view.addSubview(containerView)
  }

  func configConstraints() {
    NSLayoutConstraint.activate([
      containerView.topAnchor.constraint(equalTo: viewController.view.topAnchor),
      containerView.leadingAnchor.constraint(equalTo: viewController.view.leadingAnchor),
      containerView.trailingAnchor.constraint(equalTo: viewController.view.trailingAnchor),
      containerView.bottomAnchor.constraint(equalTo: viewController.view.bottomAnchor),

      activityIndicatorView.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
      activityIndicatorView.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
      activityIndicatorView.heightAnchor.constraint(equalToConstant: 70),
      activityIndicatorView.widthAnchor.constraint(equalToConstant: 70),

      messageLabel.topAnchor.constraint(equalTo: activityIndicatorView.bottomAnchor, constant: 20),
      messageLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 20),
      messageLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -20),
    ])
  }

  func start(message: String = "") {
    addElements()
    configConstraints()
    messageLabel.text = message
    activityIndicatorView.startAnimating()
  }

  func stop() {
    activityIndicatorView.stopAnimating()
    containerView.removeFromSuperview()
  }
}
