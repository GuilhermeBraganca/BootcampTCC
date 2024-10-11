//
//  ProfileControllerViewController.swift
//  JaChegou
//
//  Created by MacBook on 11/08/24.
//

import UIKit

class ProfileControllerViewController: UIViewController {
    
    var screen: ProfileScreen?
    
    override func loadView() {
        screen = ProfileScreen()
        view = screen
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configProtocols()
    }
    
    func configProtocols() {
        screen?.delegate = self
    }
    
    func tappedOutOfAccountButton() {
        print(#function)
    }
    
    func tappedDeleteAccountButton() {
        print(#function)
    }
}

extension ProfileControllerViewController: ProfileScreenProtocol {
    
    func tappedEditButton() {
    }
        
}
