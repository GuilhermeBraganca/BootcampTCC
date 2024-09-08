//
//  RecoverPasswordViewController.swift
//  JaChegou
//
//  Created by Fabio Cristiano Lopes on 08/09/24.
//

import Foundation
import UIKit

class RecoverPasswordViewController: UIViewController {
    
    var screen: RecoverPasswordScreen?
    
    override func loadView() {
        screen = RecoverPasswordScreen()
        view = screen
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
    }
}
