//
//  SavedTrackingViewController.swift
//  JaChegou
//
//  Created by MacBook on 03/09/24.
//

import UIKit

class LoadTrackingViewController: UIViewController {
    
    var screen: LoadTrackingScreen?
    var viewModel: LoadTrackingViewModel = LoadTrackingViewModel()
    var track: Track?
    
    
    override func loadView() {
        screen = LoadTrackingScreen()
        view = screen
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let track = track {
            print("Track recebido: \(track)")
            checkForTrackingUpdates(track: track)
            setupScreen(track: track)
        }
        configProtocols()
    }
    func checkForTrackingUpdates(track: Track) {
        viewModel.checkForUpdates(track: track)
    }
    func configProtocols(){
        screen?.delegate = self
        screen?.configTableViewProtocols(delegate: self, dataSource: self)
    }
    func setupScreen(track: Track){
        viewModel.loadTrackingData(tracking: track)
        screen?.setupSavedTrackingLabels(track: track)
        
    }
    func deleteTracking() {
        guard let track = track else { return }
        
        FirestoreManager.shared.deleteTrackFromUser(track: track) { [weak self] result in
            switch result {
            case .success:
                // Exibe uma mensagem de confirmação e retorna à tela anterior
                let alert = UIAlertController(title: "Sucesso", message: "O rastreio foi deletado.", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { _ in
                    self?.navigationController?.popViewController(animated: true) // Volta à tela anterior
                }))
                self?.present(alert, animated: true, completion: nil)
                
            case .failure(let error):
                // Exibe uma mensagem de erro
                let alert = UIAlertController(title: "Erro", message: "Falha ao deletar o rastreio: \(error.localizedDescription)", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                self?.present(alert, animated: true, completion: nil)
            }
        }
    }
    
}

extension LoadTrackingViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.numberOfRowsInSection
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: LoadTrackingTableViewCell.identifier, for: indexPath) as? LoadTrackingTableViewCell
        screen?.setupSavedTrackingLabels(track: viewModel.loadCurrentTrack())
        cell?.setupCell(events: viewModel.loadCurrentDetail(indexPath: indexPath))
        return cell ?? UITableViewCell()
    }
    
}
extension LoadTrackingViewController: LoadTrackingScreenProtocol{
    func tappedDeleteButton() {
        print("passou aqui")
        deleteTracking()
    }
    
    func tappedBackButton() {
        self.dismiss(animated: true, completion: nil)
    }
    
}
extension LoadTrackingViewController: LoadTrackingViewModelProtocol {
    func success() {
        // Atualiza a interface com os novos dados ou indica que está atualizado
        self.updateCollectionView()
    }
    
    func failure(errorMessage: String) {
        // Mostra uma mensagem de erro
        self.showErrorAlert(message: errorMessage)
    }
    
    func loading(start: Bool) {
        if start {
            LoadingLottie.shared.start(message: "Verificando atualizações...")
        } else {
            LoadingLottie.shared.stop()
        }
    }
    
    func updateCollectionView() {
        screen?.tableView.reloadData()
    }
    
    func showErrorAlert(message: String) {
        let alert = UIAlertController(title: "Erro", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    
}
