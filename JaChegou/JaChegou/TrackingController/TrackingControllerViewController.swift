//
//  TrackingControllerViewController.swift
//  JaChegou
//
//  Created by MacBook on 11/08/24.
//

import UIKit

class TrackingControllerViewController: UIViewController {

    var screen: TrackingScreen?

    override func loadView() {
      screen = TrackingScreen()
      view = screen
    }

    override func viewDidLoad() {
      super.viewDidLoad()
      //NotificationCenter.default.addObserver(self, selector: #selector(changeName), name: .changeName, object: nil)
    }

}
