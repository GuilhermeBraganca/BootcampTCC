//
//  SavedTrackingScreen.swift
//  JaChegou
//
//  Created by MacBook on 03/09/24.
//

import UIKit

protocol SavedTrackingScreenProtocol: AnyObject {
    func tappedDeleteButton()
    func tappedBackButton()
}

class SavedTrackingScreen: UIView {
    
    var track: Track?
    weak var delegate: SavedTrackingScreenProtocol?
    
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
    
    lazy var deleteTracking: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Excluir Rastreio", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .systemBlue
        button.clipsToBounds = true
        button.layer.cornerRadius = 8
        button.addTarget(self, action: #selector(tappedDeleteButton), for: .touchUpInside)
        return button
    }()
    
    lazy var closeSavedTrackingButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(systemName: "arrow.backward"), for: .normal)
        button.frame = CGRect(x: 50, y: 50, width: 100, height: 100)
        button.setTitleColor(.systemBlue, for: .normal)
        button.backgroundColor = .clear
        button.clipsToBounds = true
        button.layer.cornerRadius = 8
        button.addTarget(self, action: #selector(tappedBackButton), for: .touchUpInside)
        button.isUserInteractionEnabled = true
        return button
    }()
    
    @objc func tappedDeleteButton() {
        print(#function)
        delegate?.tappedDeleteButton()
    }
    @objc func tappedBackButton() {
        print(#function)
        delegate?.tappedBackButton()
    }
    
    init() {
        super.init(frame: .zero)
        backgroundColor = .customGray
        addElements()
        configConstraints()
    }
    func setupSavedTrackingLabels(track: Track){
        self.track = track
        productImageView.image = UIImage(systemName: "truck.box.fill")
        descriptionLabel.text = track.description
        trackingNumberLabel.text = track.trackingNumber
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
        addSubview(closeSavedTrackingButton)
        addSubview(productImageView)
        addSubview(descriptionLabel)
        addSubview(trackingNumberLabel)
        addSubview(tableView)
        addSubview(deleteTracking)
        
        
    }
    
    func configConstraints() {
        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: topAnchor),
            headerView.leadingAnchor.constraint(equalTo: leadingAnchor),
            headerView.trailingAnchor.constraint(equalTo: trailingAnchor),
            headerView.heightAnchor.constraint(equalToConstant: 150),
            
            closeSavedTrackingButton.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 30),
            closeSavedTrackingButton.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 10),
            closeSavedTrackingButton.heightAnchor.constraint(equalToConstant: 36),
            closeSavedTrackingButton.widthAnchor.constraint(equalToConstant: 36),
            
            
            productImageView.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: 10),
            productImageView.leadingAnchor.constraint(equalTo:safeAreaLayoutGuide.leadingAnchor, constant: 10),
            productImageView.heightAnchor.constraint(equalToConstant: 36),
            productImageView.widthAnchor.constraint(equalToConstant: 36),
            
            //descriptionLabel.centerYAnchor.constraint(equalTo: productImageView.centerYAnchor),
            descriptionLabel.topAnchor.constraint(equalTo: productImageView.topAnchor),
            descriptionLabel.leadingAnchor.constraint(equalTo: productImageView.trailingAnchor, constant: 10),
            descriptionLabel.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -20),
            
            trackingNumberLabel.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 5),
            trackingNumberLabel.leadingAnchor.constraint(equalTo: descriptionLabel.leadingAnchor),
            trackingNumberLabel.trailingAnchor.constraint(equalTo: descriptionLabel.trailingAnchor),
            
            tableView.topAnchor.constraint(equalTo: productImageView.bottomAnchor, constant: 20),
            tableView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: deleteTracking.topAnchor, constant: -10),
            

            deleteTracking.topAnchor.constraint(equalTo: tableView.bottomAnchor, constant: 10),
            deleteTracking.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            deleteTracking.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            deleteTracking.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -10),
        ])
    }
}
