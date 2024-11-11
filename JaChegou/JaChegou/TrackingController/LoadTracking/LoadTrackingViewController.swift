//
//  SavedTrackingViewController.swift
//  JaChegou
//
//  Created by MacBook on 03/09/24.
//

import UIKit

protocol LoadTrackingViewControllerDelegate: AnyObject {
    func didDeleteTracking()
}

class LoadTrackingViewController: UIViewController {
    
    var screen: LoadTrackingScreen?
    var viewModel: LoadTrackingViewModel = LoadTrackingViewModel()
    var track: Track?
    weak var delegate: LoadTrackingViewControllerDelegate?
    
    override func loadView() {
        screen = LoadTrackingScreen()
        view = screen
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let track = track {
            checkForTrackingUpdates(track: track)
            setupScreen(track: track)
        }
        configProtocols()
        screen?.tableView.reloadData()
    }
    
    func checkForTrackingUpdates(track: Track) {
        viewModel.checkForUpdates(track: track)
    }
    
    func configProtocols(){
        viewModel.delegate = self
        screen?.delegate = self
        screen?.configTableViewProtocols(delegate: self, dataSource: self)
    }
    
    func setupScreen(track: Track){
        viewModel.loadTrackingData(tracking: track)
        screen?.setupSavedTrackingLabels(track: track)
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
        guard let track = track else { return }
        let okAction = UIAlertAction(title: "OK", style: .destructive) { [weak self] _ in
            guard let self else { return }
            viewModel.deleteTrackingConfirmed(track: track)
        }
        let cancelAction = UIAlertAction(title: "Cancelar", style: .cancel, handler: nil)
        Alert.showAlert(title: "Deletar rastreio",
                        message: "Tem certeza de que deseja deletar o rastreio?",
                        viewController: self,
                        actions: [okAction,
                                  cancelAction])
    }
    
    func tappedBackButton() {
        self.dismiss(animated: true, completion: nil)
    }
    
}
extension LoadTrackingViewController: LoadTrackingViewModelProtocol {
    func showAlertDeleteTrackingSuccess(title: String, message: String) {
        Alert.showAlert(title: title, message: message, viewController: self)
        self.dismiss(animated: true, completion: nil)
    }
    
    func showAlertDeleteTrackingFailure(title: String, message: String) {
        Alert.showAlert(title: title, message: message, viewController: self)
    }
    
    func success(message: String) {
        screen?.tableView.reloadData()
        Alert.showAlert(title: "Atualização de Rastreamento", message: message, viewController: self)
    }
    
    func failure(errorMessage: String) {
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
