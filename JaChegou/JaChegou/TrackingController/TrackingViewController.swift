//
//  TrackingControllerViewController.swift
//  JaChegou
//
//  Created by MacBook on 11/08/24.
//

import UIKit

class TrackingViewController: UIViewController {
    
    var screen: TrackingScreen?
    var viewModel: TrackingViewModel?
    
    override func loadView() {
        // Cria o modelo inicial
        let model = TrackingModel(trackingCode: "", orderDescription: "")
        viewModel = TrackingViewModel(model: model)
        
        screen = TrackingScreen()
        view = screen
        screen?.viewModel = viewModel
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

