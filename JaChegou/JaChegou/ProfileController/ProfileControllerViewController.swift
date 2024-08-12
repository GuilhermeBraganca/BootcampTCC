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
      //NotificationCenter.default.addObserver(self, selector: #selector(changeName), name: .changeName, object: nil)
    }

}
