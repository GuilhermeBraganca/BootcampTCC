//
//  SavedTrackingViewController.swift
//  JaChegou
//
//  Created by MacBook on 03/09/24.
//

import UIKit

class SavedTrackingViewController: UIViewController {

    var screen: SavedTrackingScreen?
    var SavedTrackingList: SavedTrackingViewModel = SavedTrackingViewModel()
    
    override func loadView() {
        screen = SavedTrackingScreen()
        view = screen
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configProtocols()
    }
    func configProtocols(){
        screen?.delegate = self
        screen?.configTableViewProtocols(delegate: self, dataSource: self)
    }
    func deleteAllItems() {
        // Esvaziar a fonte de dados
        SavedTrackingList.removeAll()
        
        // Atualizar a tabela
        screen?.tableView.reloadData()
    }
    
}

extension SavedTrackingViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        SavedTrackingList.numberOfRowsInSection
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SavedTrackingTableViewCell.identifier, for: indexPath) as? SavedTrackingTableViewCell
        screen?.setupSavedTrackingLabels(track: SavedTrackingList.loadCurrentTrack())
        cell?.setupCell(events: SavedTrackingList.loadCurrentDetail(indexPath: indexPath))
        return cell ?? UITableViewCell()
    }
    
}
extension SavedTrackingViewController: SavedTrackingScreenProtocol{
    func tappedDeleteButton() {
        print("passou aqui")
        deleteAllItems() 
    }
    
    func tappedBackButton() {
        self.dismiss(animated: true, completion: nil)
    }

}
