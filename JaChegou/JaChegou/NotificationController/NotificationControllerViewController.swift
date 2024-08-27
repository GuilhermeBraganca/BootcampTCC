//
//  NotificationControllerViewController.swift
//  JaChegou
//
//  Created by MacBook on 11/08/24.
//

import UIKit

class NotificationControllerViewController: UIViewController {
    
    var screen: NotificationScreen?
    
    var listProduct: [Product] = [Product(name: "Sapatos", codeProduct: "AB123456789BR", eventProduct: "Objeto em trânsito para Unidade de Distribuição", image: "truck.box.fill"),
                                  Product(name: "Sapatos2", codeProduct: "BA987654321BR", eventProduct: "Objeto em trânsito para Unidade de Distribuição", image: "truck.box.fill"),
                                  Product(name: "Sapatos3", codeProduct: "CC456123987BR", eventProduct: "Objeto em trânsito para Unidade de Distribuição", image: "truck.box.fill"),
                                  Product(name: "Sapatos4", codeProduct: "CC456123987BR", eventProduct: "Objeto em trânsito para Unidade de Distribuição", image: "truck.box.fill"),
                                  Product(name: "Sapatos5", codeProduct: "CC456123987BR", eventProduct: "Objeto em trânsito para Unidade de Distribuição", image: "truck.box.fill"),
                                  Product(name: "Sapatos6", codeProduct: "CC456123987BR", eventProduct: "Objeto em trânsito para Unidade de Distribuição", image: "truck.box.fill"),
                                  Product(name: "Sapatos7", codeProduct: "CC456123987BR", eventProduct: "Objeto em trânsito para Unidade de Distribuição", image: "truck.box.fill"),
                                  Product(name: "Sapatos8", codeProduct: "CC456123987BR", eventProduct: "Objeto em trânsito para Unidade de Distribuição", image: "truck.box.fill"),
                                  Product(name: "Sapatos9", codeProduct: "CC456123987BR", eventProduct: "Objeto em trânsito para Unidade de Distribuição", image: "truck.box.fill"),
                                  Product(name: "Sapatos10", codeProduct: "CC456123987BR", eventProduct: "Objeto em trânsito para Unidade de Distribuição", image: "truck.box.fill")]
    
    override func loadView() {
        screen = NotificationScreen()
        view = screen
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        screen?.tableView.delegate = self
        screen?.tableView.dataSource = self
        screen?.tableView.layoutIfNeeded() //atualiza o layout da tableView
        footerButtonView()
        
    }
    
    private func footerButtonView() {
        let footerView = UIView()
        footerView.backgroundColor = .black
        
        let deleteButton = UIButton(type: .system)
        deleteButton.setTitle("Excluir todas notificações", for: .normal)
        deleteButton.setTitleColor(.white, for: .normal)
        deleteButton.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        deleteButton.clipsToBounds = true
        deleteButton.layer.cornerRadius = 16
        deleteButton.backgroundColor = .systemBlue
        deleteButton.translatesAutoresizingMaskIntoConstraints = false
        
        
        footerView.addSubview(deleteButton)
        
        NSLayoutConstraint.activate([
            deleteButton.topAnchor.constraint(equalTo: footerView.topAnchor, constant: 10),
            deleteButton.leadingAnchor.constraint(equalTo: footerView.leadingAnchor, constant: 10),
            deleteButton.trailingAnchor.constraint(equalTo: footerView.trailingAnchor, constant: -10),
            deleteButton.heightAnchor.constraint(equalToConstant: 40),
            deleteButton.bottomAnchor.constraint(equalTo: footerView.bottomAnchor, constant: -10)
        ])
        
        // Defina a altura do footerView
        footerView.frame.size.height = 60
        
        // Atribua o footerView à tableFooterView da tableView
        screen?.tableView.tableFooterView = footerView
        
        // Adiciona a ação ao botão
        deleteButton.addTarget(self, action: #selector(deleteAllProducts), for: .touchUpInside)
        
    }
    
    @objc private func deleteAllProducts() {
        listProduct.removeAll()
        screen?.tableView.reloadData()
    }
}

extension NotificationControllerViewController: UITableViewDelegate, UITableViewDataSource {
    // retornar para tableView quantas LINHAS teremos na tabela
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listProduct.count
    }
    // onde configuramos a nossa célula!!
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ProductTableViewCell.identifier, for: indexPath) as? ProductTableViewCell
        cell?.delegate = self
        cell?.setupCell(product: listProduct[indexPath.row])
        return cell ?? UITableViewCell()
    }
    // identifica qual produto foi selecionado
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let product = listProduct[indexPath.row]
        print(product.name)
    }
    
    // quando deslizar a célula para esquerda será apresentado botão vermelho de excluir
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    
    // exclusão da célula notificação produto
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            tableView.beginUpdates()
            listProduct.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            tableView.endUpdates()
            tableView.reloadData()
        }
    }
}
// exclusão da célula notificação produto
extension NotificationControllerViewController: ProductTableViewCellProtocol {
    func tappedDeleteProduct(product: Product?) {
        guard let product else { return }
    }
}
