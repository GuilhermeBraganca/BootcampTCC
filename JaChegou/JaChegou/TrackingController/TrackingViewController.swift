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
            self.showOKAlert(title: "Atenção!", message: "Por favor, preencha todos os campos")
            return
        }
        
        if (trackingCode == "NM455753072BR"){
            viewModel.saveMockTrackingData(code: trackingCode, description: orderDescription)
        }else{
            viewModel.saveTrackingData(code: trackingCode, description: orderDescription)
        }
        
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
        self.showOKAlert(title: "Sucesso", message: "Cadastro realizado com sucesso.")
        screen?.trackingCodeTextField.text = ""
        screen?.orderDescriptionTextField.text = ""
    }
    
    func failure(errorMessage: String) {
        self.showOKAlert(title: "Erro", message: errorMessage)
    }
}

