//
//  NotificationControllerViewController.swift
//  JaChegou
//
//  Created by MacBook on 11/08/24.
//

import UIKit

class NotificationControllerViewController: UIViewController {

    var screen: NotificationScreen?

    override func loadView() {
      screen = NotificationScreen()
      view = screen
    }

    override func viewDidLoad() {
      super.viewDidLoad()
      //NotificationCenter.default.addObserver(self, selector: #selector(changeName), name: .changeName, object: nil)
    }

}
