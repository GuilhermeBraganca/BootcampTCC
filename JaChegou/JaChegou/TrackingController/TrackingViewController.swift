//
//  TrackingControllerViewController.swift
//  JaChegou
//
//  Created by MacBook on 11/08/24.
//

import UIKit

class TrackingViewController: UIViewController {
    
    var screen: TrackingScreen?
    var viewModel: TrackingViewModel = TrackingViewModel()
    var loading: Loading?
    
    override func loadView() {
        screen = TrackingScreen()
        view = screen
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
      screen?.delegate = self
      viewModel.delegate = self
      loading = Loading(viewController: self)
    }
}

extension TrackingViewController: TrackingScreenProtocol {
  func tapped() {
    viewModel.saveTrackingData(code: screen?.trackingCodeTextField.text ?? "", description: screen?.orderDescriptionTextField.text ?? "")
  }
}

extension TrackingViewController: TrackingViewModelProtocol {
    func loading(start: Bool) {
        if start {
          LoadingLottie.shared.start(message: "Carregando...")
        } else {
            LoadingLottie.shared.stop()
        }
      }
    
    
  func success() {

  }
  
  func failure(errorMessage: String) {

  }
}

