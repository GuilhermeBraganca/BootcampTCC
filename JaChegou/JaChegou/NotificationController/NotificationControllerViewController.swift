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
    }
}
                                          
extension NotificationControllerViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let product = listProduct[indexPath.row]
        print(product.name)
    }
}

extension NotificationControllerViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listProduct.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ProductTableViewCell.identifier, for: indexPath) as? ProductTableViewCell
        cell?.delegate = self
        cell?.setupCell(product: listProduct[indexPath.row])
        return cell ?? UITableViewCell()
    }
}

extension NotificationControllerViewController: ProductTableViewCellProtocol {
    func tappedDeleteProduct(product: Product?) {
        guard let product else { return }
    }
}
