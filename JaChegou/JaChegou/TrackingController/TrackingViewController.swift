//
//  TrackingControllerViewController.swift
//  JaChegou
//
//  Created by MacBook on 11/08/24.
//

import UIKit

class TrackingViewController: UIViewController {
    
    var screen: TrackingScreen?
    
    override func loadView() {
        screen = TrackingScreen()
        view = screen
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
}
