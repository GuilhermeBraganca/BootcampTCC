//
//  NotificationControllerViewController.swift
//  JaChegou
//
//  Created by MacBook on 11/08/24.
//

import UIKit

class NotificationViewController: UIViewController {
    
    var screen: NotificationScreen?
    var viewModel = NotificationViewModel()
    
    override func loadView() {
        screen = NotificationScreen()
        view = screen
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.getAllEvents()
        screen?.tableView.reloadData()
        configProtocols()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        viewModel.getAllEvents()
        screen?.tableView.reloadData()
    }
    
    func configProtocols(){
        screen?.tableView.delegate = self
        screen?.tableView.dataSource = self
    }
    
}
extension NotificationViewController: NotificationViewModelDelegate {
    func showAlert(title: String, message: String) {
        Alert.showAlert(title: title, message: message, viewController: self)
    }
}

extension NotificationViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRowsInSection
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ProductTableViewCell.identifier, for: indexPath) as? ProductTableViewCell
        let trackWithLastEvent = viewModel.trackWithLastEvent(at: indexPath)
        cell?.setupCell(track: trackWithLastEvent.track, event: trackWithLastEvent.lastEvent)
        return cell ?? UITableViewCell()
    }
    
}
