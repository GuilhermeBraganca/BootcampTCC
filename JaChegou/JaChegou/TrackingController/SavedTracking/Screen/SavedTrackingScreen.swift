//
//  SavedTrackingScreen.swift
//  JaChegou
//
//  Created by MacBook on 03/09/24.
//

import UIKit

class SavedTrackingScreen: UIView {
    
    var track: Track?
    
    lazy var headerView: HeaderView = {
        let view = HeaderView(title: "", image: UIImage(named: "worldImage"))
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var productImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.backgroundColor = .customLightGray
        imageView.layer.cornerRadius = 8
        return imageView
    }()
    
    lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.text = "Sapatos"
        label.numberOfLines = 2
        label.textColor = .white
        label.textAlignment = .left
        return label
    }()
    
    lazy var trackingNumberLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 12)
        label.text = "AB 123456789 BR"
        label.textColor = .white
        label.textAlignment = .left
        return label
    }()
    
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(SavedTrackingTableViewCell.self, forCellReuseIdentifier: SavedTrackingTableViewCell.identifier)
        tableView.backgroundColor = .customGray
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
        button.addTarget(self, action: #selector(tappedDeleteButton), for: .touchUpInside)
        return button
    }()
    
    @objc func tappedDeleteButton() {
        print(#function)
    }
    
    
    init() {
        super.init(frame: .zero)
        backgroundColor = .customGray
        addElements()
        configConstraints()
    }
    func setupSavedTrackingLabels(track: Track){
        self.track = track
        productImageView.image = UIImage(systemName: track.image)
        descriptionLabel.text = track.description
        trackingNumberLabel.text = track.trackinNumber
    }
    func configTableViewProtocols(delegate: UITableViewDelegate, dataSource: UITableViewDataSource) {
        tableView.delegate = delegate
        tableView.dataSource = dataSource
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addElements() {
        addSubview(headerView)
        addSubview(productImageView)
        addSubview(descriptionLabel)
        addSubview(trackingNumberLabel)
        addSubview(tableView)
        addSubview(deleteAllNotificationsButton)
    }
    
    func configConstraints() {
        NSLayoutConstraint.activate([
            
            headerView.topAnchor.constraint(equalTo: topAnchor),
            headerView.leadingAnchor.constraint(equalTo: leadingAnchor),
            headerView.trailingAnchor.constraint(equalTo: trailingAnchor),
            headerView.heightAnchor.constraint(equalToConstant: 200),
            
            productImageView.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: 10),
            productImageView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 10),
            productImageView.heightAnchor.constraint(equalToConstant: 36),
            productImageView.widthAnchor.constraint(equalToConstant: 36),
            
            descriptionLabel.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: 10),
            descriptionLabel.leadingAnchor.constraint(equalTo: productImageView.trailingAnchor, constant: 10),
            //descriptionLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            
            trackingNumberLabel.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 1),
            trackingNumberLabel.leadingAnchor.constraint(equalTo: descriptionLabel.leadingAnchor),
            trackingNumberLabel.trailingAnchor.constraint(equalTo: descriptionLabel.trailingAnchor),
            
            
            tableView.topAnchor.constraint(equalTo: productImageView.bottomAnchor, constant: 10),
            tableView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            
            deleteAllNotificationsButton.topAnchor.constraint(equalTo: tableView.bottomAnchor, constant: 0),
            deleteAllNotificationsButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            deleteAllNotificationsButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            deleteAllNotificationsButton.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -10),
            
        ])
    }
}
