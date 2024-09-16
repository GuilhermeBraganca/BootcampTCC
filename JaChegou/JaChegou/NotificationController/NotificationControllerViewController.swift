//
//  NotificationControllerViewController.swift
//  JaChegou
//
//  Created by MacBook on 11/08/24.
//

import UIKit

class NotificationControllerViewController: UIViewController {
    
    var screen: NotificationScreen?
    var viewModel = NotificationViewModel()
    
    override func loadView() {
        screen = NotificationScreen()
        view = screen
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        screen?.tableView.delegate = self
        screen?.tableView.dataSource = self
        setupBindings()
        viewModel.loadProducts()
    }
    
    private func setupBindings() {
        viewModel.reloadTableView = { [weak self] in
            self?.screen?.tableView.reloadData()
        }
    }
}

extension NotificationControllerViewController: UITableViewDelegate, UITableViewDataSource {
    
    //Apresenta quantidade de linhas (produtos) que vai ser exibido.
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfProducts
    }
    
    //Método configura a célula com os dados do produto.
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ProductTableViewCell.identifier, for: indexPath) as? ProductTableViewCell
        let product = viewModel.product(at: indexPath.row)
        cell?.setupCell(product: product)
        return cell ?? UITableViewCell()
    }
    
    //Método é chamado quando é selecionado a célula
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let product = viewModel.product(at: indexPath.row)
        print(product.name)
    }
    
    //Método para excluir célula (deslizando para excluir).
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            viewModel.deleteProduct(at: indexPath.row)
        }
    }
}
