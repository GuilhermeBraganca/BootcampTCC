//
//  NotificationScreen.swift
//  JaChegou
//
//  Created by MacBook on 11/08/24.
//

import UIKit

class NotificationScreen: UIView {
    
    lazy var headerView: HeaderView = {
        let view = HeaderView(title: "Notificações enviadas", image: UIImage(named: "worldImage"))
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(ProductTableViewCell.self, forCellReuseIdentifier: ProductTableViewCell.identifier)
        tableView.backgroundColor = .black
        tableView.layer.cornerRadius = 8
        tableView.separatorStyle = .none
        return tableView
    }()
    
    lazy var deleteAllNotificationsButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Excluir todas notificações", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .systemBlue
        button.clipsToBounds = true
        button.layer.cornerRadius = 8
        button.addTarget(self, action: #selector(tappedSaveButton), for: .touchUpInside)
        return button
    }()
    
    @objc func tappedSaveButton() {
        print(#function)
    }
    
    
    init() {
        super.init(frame: .zero)
        backgroundColor = UIColor(hex: "#272A2E")
        layer.cornerRadius = 8
        addElements()
        configConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addElements() {
        addSubview(headerView)
        addSubview(tableView)
        addSubview(deleteAllNotificationsButton)
        
    }
    
    func configConstraints() {
        NSLayoutConstraint.activate([
            
            headerView.topAnchor.constraint(equalTo: topAnchor),
            headerView.leadingAnchor.constraint(equalTo: leadingAnchor),
            headerView.trailingAnchor.constraint(equalTo: trailingAnchor),
            headerView.heightAnchor.constraint(equalToConstant: 200),
            
            tableView.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: 5),
            tableView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            
            deleteAllNotificationsButton.topAnchor.constraint(equalTo: tableView.bottomAnchor, constant: 0),
            deleteAllNotificationsButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            deleteAllNotificationsButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            deleteAllNotificationsButton.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -5),
            
        ])
    }
    
}
