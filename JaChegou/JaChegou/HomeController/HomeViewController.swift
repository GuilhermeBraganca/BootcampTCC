//
//  HomeControllerViewController.swift
//  JaChegou
//
//  Created by MacBook on 11/08/24.
//

import UIKit


class HomeViewController: UIViewController {
    
    var screen: HomeControllerScreen?
    var viewModel: HomeViewModel = HomeViewModel()
    
    
    override func viewWillAppear(_ animated: Bool) {
        
        
        // Defina o ViewController como delegate do ViewModel
        viewModel.delegate = self
        
        // Buscar os tracks do usuário no Firestore
        FirestoreManager.shared.getTracksFromUser { [weak self] (result: Result<[Track], Error>) in
            
            DispatchQueue.main.async {
                guard let self = self else { return }
                switch result {
                case .success(let tracks):
                    // Notifique o ViewModel que os dados foram carregados
                    self.viewModel.allTrackList = tracks
                    self.viewModel.updateTrackFilter() // Atualiza o trackFilter no ViewModel
                    
                    // Atualize a CollectionView com os novos dados
                    self.updateCollectionView()
                    
                case .failure(let error):
                    print("Erro ao recuperar os dados: \(error.localizedDescription)")
                }
            }
        }
        
    }
    
    override func loadView() {
        screen = HomeControllerScreen()
        view = screen
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configProtocols()
    }
    func configProtocols() {
        screen?.delegate = self
        screen?.configCollectionViewProtocols(delegate: self, dataSource: self)
        screen?.configSearchBarProtocol(delegate: self)
    }
    
    func updateCollectionView() {
        // Atualiza a UICollectionView com os novos dados
        screen?.collectionView.reloadData()
    }
}
extension HomeViewController: HomeViewModelDelegate {
    func didLoadTracks(tracks: [Track]) {
        self.viewModel.allTrackList = tracks
        self.viewModel.updateTrackFilter()
        self.updateCollectionView()
    }
    
    
}
extension HomeViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        viewModel.filterTrack(text: searchText)
        screen?.collectionView.reloadData()
    }
}

extension HomeViewController: HomeControllerScreenProtocol {
    func changeTrackingType(type: TrackingType) {
        viewModel.setNewTrackingType(newType: type)
        screen?.collectionView.reloadData()
    }
    func loading(start: Bool) {
        if start {
            LoadingLottie.shared.start(message: "Carregando...")
        } else {
            LoadingLottie.shared.stop()
        }
    }
}


extension HomeViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.numberOfRowsInSection
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if viewModel.totalOfTrackingList == 0{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: EmptyTrackingCollectionViewCell.identifier, for: indexPath) as? EmptyTrackingCollectionViewCell
            return cell ?? UICollectionViewCell()
        }else{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TrackCollectionViewCell.identifier, for: indexPath) as? TrackCollectionViewCell
            cell?.setupCell(item: viewModel.loadCurrentDetail(indexPath: indexPath))
            return cell ?? UICollectionViewCell()
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let padding: CGFloat = 18
        let itemWidth = viewModel.totalOfTrackingList == 0 ? (view.frame.width - padding * 3) : (view.frame.width - padding * 3) / 2
        return CGSize(width: itemWidth, height: itemWidth)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        // Verifica se o número de itens na seção é 0 (ou seja, estamos exibindo a célula vazia)
        if viewModel.totalOfTrackingList == 0  {
            if let tabBarController = self.tabBarController {
                UIView.setAnimationsEnabled(false)
                tabBarController.selectedIndex = 1
                UIView.setAnimationsEnabled(true)
            }
        } else {
            
            let savedTrackingVC = SavedTrackingViewController()
            savedTrackingVC.track = viewModel.loadCurrentDetail(indexPath: indexPath)
            let navigationController = UINavigationController(rootViewController: savedTrackingVC)
            present(navigationController, animated: false, completion: nil)
        }
        
    }
    
    
}
