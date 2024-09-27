//
//  LoadingLottie.swift
//  ImplementandoFirebase
//
//  Created by Caio Fabrini on 26/08/24.
//

import Foundation
import UIKit
import Lottie

final class LoadingLottie: UIView {

  static let shared = LoadingLottie()

  lazy var animationLottieView: LottieAnimationView = {
    let loading = LottieAnimationView(name: "loading_animation") // Espera o json com esse nome
    loading.translatesAutoresizingMaskIntoConstraints = false
    loading.loopMode = .loop
    loading.backgroundColor = .black.withAlphaComponent(0.8)
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
    addSubview(animationLottieView)
    addSubview(messageLabel)
  }

  func configConstraints() {
    NSLayoutConstraint.activate([
      animationLottieView.centerXAnchor.constraint(equalTo: centerXAnchor),
      animationLottieView.centerYAnchor.constraint(equalTo: centerYAnchor),
      animationLottieView.heightAnchor.constraint(equalToConstant: 200),
      animationLottieView.widthAnchor.constraint(equalToConstant: 200),

      messageLabel.topAnchor.constraint(equalTo: animationLottieView.bottomAnchor, constant: 20),
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
    animationLottieView.play()
  }

  func stop() {
    animationLottieView.stop()
    removeFromSuperview()
  }
}

