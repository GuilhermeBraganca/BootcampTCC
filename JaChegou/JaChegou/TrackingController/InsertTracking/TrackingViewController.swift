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
        
        if (trackingCode == "NM455753072BR" ||  trackingCode == "NM455753073BR" ||  trackingCode == "NM455753074BR" ||  trackingCode == "NM455753075BR"){
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
        let alertController = UIAlertController(title: "Sucesso", message: "Cadastro realizado com sucesso.", preferredStyle: .alert)
        
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
        
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
    }
    
    func failure(errorMessage: String) {
        self.showOKAlert(title: "Erro", message: errorMessage)
    }
}

