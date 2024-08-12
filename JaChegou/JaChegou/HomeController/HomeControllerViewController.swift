//
//  HomeControllerViewController.swift
//  JaChegou
//
//  Created by MacBook on 11/08/24.
//

import UIKit

class HomeControllerViewController: UIViewController {

    var screen: HomeControllerScreen?

    override func loadView() {
      screen = HomeControllerScreen()
      view = screen
    }

    override func viewDidLoad() {
      super.viewDidLoad()
      //NotificationCenter.default.addObserver(self, selector: #selector(changeName), name: .changeName, object: nil)
    }
    

}
