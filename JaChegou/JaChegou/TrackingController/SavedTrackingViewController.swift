//
//  SavedTrackingViewController.swift
//  JaChegou
//
//  Created by MacBook on 03/09/24.
//

import UIKit

class SavedTrackingViewController: UIViewController {

    var screen: SavedTrackingScreen?
    
    override func loadView() {
        screen = SavedTrackingScreen()
        view = screen
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

}
