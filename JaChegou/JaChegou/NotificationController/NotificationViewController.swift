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
        getAllEvents()
        screen?.tableView.reloadData()
        configProtocols()
        
    }
    override func viewWillAppear(_ animated: Bool) {
        getAllEvents()
        screen?.tableView.reloadData()
    }
    func configProtocols(){
        screen?.tableView.delegate = self
        screen?.tableView.dataSource = self
    }
    func getAllEvents(){
        FirestoreManager.shared.getUserData{ [weak self] result in
            switch result {
            case .success(let userData):
                let trackWithLastEvents = userData.track.compactMap { track -> NotificationViewModel.TrackWithLastEvent? in
                    guard let lastEvent = track.events.first else { return nil }
                    return NotificationViewModel.TrackWithLastEvent(track: track, lastEvent: lastEvent)
                }
                self?.viewModel.trackWithLastEvents = trackWithLastEvents
                self?.screen?.tableView.reloadData()
            case .failure(let error):
                print("Erro ao carregar os dados de rastreamento: \(error.localizedDescription)")
            }
        }
    }
}

extension NotificationViewController: UITableViewDelegate, UITableViewDataSource {
    
    //Apresenta quantidade de linhas (produtos) que vai ser exibido.
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRowsInSection
    }
    
    //Método configura a célula com os dados do produto.
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ProductTableViewCell.identifier, for: indexPath) as? ProductTableViewCell
        
        // Obtém o track e o último evento
        let trackWithLastEvent = viewModel.trackWithLastEvent(at: indexPath)
        
        // Configura a célula com o track e o último evento
        cell?.setupCell(track: trackWithLastEvent.track, event: trackWithLastEvent.lastEvent)
        
        return cell ?? UITableViewCell()
    }
    
}
