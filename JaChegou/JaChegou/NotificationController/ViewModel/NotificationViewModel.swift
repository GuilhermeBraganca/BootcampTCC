//
//  NotificationViewModel.swift
//  JaChegou
//
//  Created by Fabio Cristiano Lopes on 14/09/24.
//

import Foundation

class NotificationViewModel {
    
    private var products: [Product] = []
    
    //Variável usado para interagir a ViewController quando os dados da tabela devem ser atualizados.
    var reloadTableView: (() -> Void)?
    
    var numberOfProducts: Int {
        return products.count
    }
    
    func product(at index: Int) -> Product {
        return products[index]
    }
    
    func loadProducts() {
        // Inicializa os produtos.
        products = [Product(name: "Sapatos", codeProduct: "AB123456789BR", eventProduct: "Objeto em trânsito para Unidade de Distribuição", image: "truck.box.fill"),
                    Product(name: "Sapatos2", codeProduct: "BA987654321BR", eventProduct: "Objeto em trânsito para Unidade de Distribuição", image: "truck.box.fill"),
                    Product(name: "Sapatos3", codeProduct: "CC456123987BR", eventProduct: "Objeto em trânsito para Unidade de Distribuição", image: "truck.box.fill"),
                    Product(name: "Sapatos4", codeProduct: "CC456123987BR", eventProduct: "Objeto em trânsito para Unidade de Distribuição", image: "truck.box.fill"),
                    Product(name: "Sapatos5", codeProduct: "CC456123987BR", eventProduct: "Objeto em trânsito para Unidade de Distribuição", image: "truck.box.fill"),
                    Product(name: "Sapatos6", codeProduct: "CC456123987BR", eventProduct: "Objeto em trânsito para Unidade de Distribuição", image: "truck.box.fill"),
                    Product(name: "Sapatos7", codeProduct: "CC456123987BR", eventProduct: "Objeto em trânsito para Unidade de Distribuição", image: "truck.box.fill"),
                    Product(name: "Sapatos8", codeProduct: "CC456123987BR", eventProduct: "Objeto em trânsito para Unidade de Distribuição", image: "truck.box.fill"),
                    Product(name: "Sapatos9", codeProduct: "CC456123987BR", eventProduct: "Objeto em trânsito para Unidade de Distribuição", image: "truck.box.fill"),
                    Product(name: "Sapatos10", codeProduct: "CC456123987BR", eventProduct: "Objeto em trânsito para Unidade de Distribuição", image: "truck.box.fill")]
        
        reloadTableView?()
    }
    
    // Função para remover um produto especifico
    func deleteProduct(at index: Int) {
        products.remove(at: index)
        reloadTableView?() //Atualizar a tela de notificações
    }
}
