//
//  HomeControllerViewController.swift
//  JaChegou
//
//  Created by MacBook on 11/08/24.
//

import UIKit


class HomeViewController: UIViewController {
    
    var screen: HomeControllerScreen?
    var viewModel: ListViewModel = ListViewModel()
    
    override func loadView() {
        screen = HomeControllerScreen()
        view = screen
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: UIView())
        screen?.delegate = self
        screen?.configCollectionViewProtocols(delegate: self, dataSource: self)
    }
}

extension HomeViewController: HomeControllerScreenProtocol {
    func changeTrackingType(type: TrackingType) {
        viewModel.setNewTrackingType(newType: type)
        screen?.collectionView.reloadData()
    }
}

extension HomeViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.numberOfRowsInSection
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if viewModel.numberOfRowsInSection == 1{
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
        let itemWidth = viewModel.numberOfRowsInSection == 1 ? (view.frame.width - padding * 3) : (view.frame.width - padding * 3) / 2
        
        return CGSize(width: itemWidth, height: itemWidth)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        // Verifica se o número de itens na seção é 0 (ou seja, estamos exibindo a célula vazia)
        if viewModel.numberOfRowsInSection == 1  {
            // Verifica se há um tabBarController disponível
            if let tabBarController = self.tabBarController {
                // Muda para a aba onde o TrackingViewController está
                tabBarController.selectedIndex = 1  // Substitua pelo índice correto da aba do TrackingViewController
            }
        } else {
            // Caso contrário, lidamos com a célula de tracking selecionada
            let savedTrackingVC = SavedTrackingViewController()
            let navigationController = UINavigationController(rootViewController: savedTrackingVC)
            present(navigationController, animated: true, completion: nil)
        }
        
    }
        
        
}
