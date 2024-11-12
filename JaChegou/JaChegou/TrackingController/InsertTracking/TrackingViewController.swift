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
        guard let orderDescription: String = screen?.orderDescriptionTextField.text,
              let trackingCode: String = screen?.trackingCodeTextField.text,
              !orderDescription.isEmpty,
              !trackingCode.isEmpty else {
            Alert.showAlert(title: "Atenção!", message: "Por favor, preencha todos os campos", viewController: self)
            return
        }
        viewModel.saveTrackingData(code: trackingCode, description: orderDescription)
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
        let okAction = UIAlertAction(title: "OK", style: .default) { [weak self] _ in
            guard let self else { return }
            
            self.screen?.trackingCodeTextField.text = ""
            self.screen?.orderDescriptionTextField.text = ""
            
            if let tabBarController = self.tabBarController {
                UIView.setAnimationsEnabled(false)
                tabBarController.selectedIndex = 0
                UIView.setAnimationsEnabled(true)
            }
        }
        Alert.showAlert(title: "Sucesso", message: "Cadastro realizado com sucesso.", viewController: self, actions: [okAction])
    }
    
    func failure(errorMessage: String) {
        Alert.showAlert(title: "Erro", message: errorMessage, viewController: self)
    }
}

