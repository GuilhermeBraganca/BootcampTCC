//
//  NotificationScreen.swift
//  JaChegou
//
//  Created by MacBook on 11/08/24.
//

import UIKit

class NotificationScreen: UIView {
    
    lazy var headerView: HeaderView = {
        let view = HeaderView(title: "Notificações enviadas:", image: UIImage(named: "worldImage"))
        view.translatesAutoresizingMaskIntoConstraints = false
        view.titleLabel.font = UIFont.boldSystemFont(ofSize: 35)
        return view
    }()
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(ProductTableViewCell.self, forCellReuseIdentifier: ProductTableViewCell.identifier)
        tableView.backgroundColor = .black
        tableView.separatorStyle = .none
        return tableView
    }()
    
    
    init() {
        super.init(frame: .zero)
        backgroundColor = .black
        addElements()
        configConstraints()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addElements() {
        addSubview(headerView)
        addSubview(tableView)
        
    }
    
    func configConstraints() {
        NSLayoutConstraint.activate([
            
            headerView.topAnchor.constraint(equalTo: topAnchor),
            headerView.leadingAnchor.constraint(equalTo: leadingAnchor),
            headerView.trailingAnchor.constraint(equalTo: trailingAnchor),
            headerView.heightAnchor.constraint(equalToConstant: 200),
            
            tableView.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: 10),
            tableView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -10),
            
            
        ])
    }
    
}
