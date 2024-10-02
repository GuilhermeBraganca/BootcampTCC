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
    var track: TrackingDTO?
    
    
    override func loadView() {
        screen = SavedTrackingScreen()
        view = screen
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let track = track {
            print("Track recebido: \(track)")
            setupScreen(track: track)
        }
        configProtocols()
    }
    func configProtocols(){
        screen?.delegate = self
        screen?.configTableViewProtocols(delegate: self, dataSource: self)
    }
    func setupScreen(track: TrackingDTO){
        SavedTrackingList.loadTrackingData(tracking: track)
        screen?.setupSavedTrackingLabels(track: track)
        
    }
    func deleteTracking() {
        guard let track = track else { return }
        // Recupera a lista de rastreios do UserDefaults
        var trackingList = UserDefaults.standard.object(forKey: "ListTrackingDTO") as? [TrackingDTO] ?? []
        // Filtra a lista para remover o item com o mesmo código
        trackingList.removeAll { $0.code == track.code }
        // Salva a lista atualizada no UserDefaults
        UserDefaults.standard.set(try? PropertyListEncoder().encode(trackingList), forKey: "ListTrackingDTO")
        // Exibe uma mensagem de confirmação e retorna à tela anterior
        let alert = UIAlertController(title: "Sucesso", message: "O rastreio foi deletado.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { _ in
            self.navigationController?.popViewController(animated: true) // Volta à tela anterior
        }))
        present(alert, animated: true, completion: nil)
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
        deleteTracking()
    }
    
    func tappedBackButton() {
        self.dismiss(animated: true, completion: nil)
    }
    
}
