//
//  Alert.swift
//  JaChegou
//
//  Created by Fabio Cristiano Lopes on 08/11/24.
//

import UIKit

class Alert {
    static func showAlert (title: String, message: String, viewController: UIViewController ) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        viewController.present(alert, animated: true, completion: nil)
    }
}
