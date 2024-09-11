//
//  HomeControllerScreen.swift
//  JaChegou
//
//  Created by MacBook on 11/08/24.
//

import Foundation
import UIKit

protocol HomeControllerScreenProtocol: AnyObject {
  func changeTrackingType(type: TrackingType)
}

class HomeControllerScreen: UIView {

  weak var delegate: HomeControllerScreenProtocol?
    
    lazy var headerView: HeaderView = {
        let view = HeaderView(title: "Rastreamentos", image: UIImage(named: "World"))
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    lazy var trackingLabel: UILabel = {
        let label = UILabel()
        label.text = "Rastreamentos"
        label.numberOfLines = 1
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 30)
        return label
    }()
    
    lazy var searchBarView: SearchBarView = {
        let view = SearchBarView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .customGray
        view.layer.cornerRadius = 30
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = 0.1
        view.layer.shadowOffset = CGSize(width: 0, height: 2)
        view.layer.shadowRadius = 8
        return view
    }()
    
    lazy var segmentedControl: UISegmentedControl = {
        let control = UISegmentedControl(items: ["Em Transporte", "Concluído"])
        control.selectedSegmentIndex = 0 // Começa com a primeira opção selecionada
        control.backgroundColor = .black
        control.layer.cornerRadius = 15
        control.layer.masksToBounds = true
        
        control.selectedSegmentTintColor = .white
        control.setTitleTextAttributes([.foregroundColor: UIColor.white], for: .normal)
        control.setTitleTextAttributes([.foregroundColor: UIColor.systemBlue], for: .selected)
        control.translatesAutoresizingMaskIntoConstraints = false
        control.addTarget(self, action: #selector(segmentChanged), for: .valueChanged)
        return control
    }()
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.scrollDirection = .vertical
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.backgroundColor = .black
        collectionView.register(TrackCollectionViewCell.self, forCellWithReuseIdentifier: TrackCollectionViewCell.identifier)
        collectionView.register(EmptyTrackingCollectionViewCell.self, forCellWithReuseIdentifier: EmptyTrackingCollectionViewCell.identifier)
        return collectionView
    }()
    
    @objc private func segmentChanged() {
        if segmentedControl.selectedSegmentIndex == 0 {
          delegate?.changeTrackingType(type: .transporting)
        } else {
          delegate?.changeTrackingType(type: .completed)
        }
    }
    
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
        addSubview(searchBarView)
        addSubview(segmentedControl)
        addSubview(collectionView)
    }
    
    func configCollectionViewProtocols(delegate: UICollectionViewDelegate, dataSource: UICollectionViewDataSource) {
      collectionView.delegate = delegate
      collectionView.dataSource = dataSource
    }
    
    func configConstraints(){
        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: topAnchor),
            headerView.leadingAnchor.constraint(equalTo: leadingAnchor),
            headerView.trailingAnchor.constraint(equalTo: trailingAnchor),
            headerView.heightAnchor.constraint(equalToConstant: 100),
            
            searchBarView.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: 16),
            searchBarView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            searchBarView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            searchBarView.heightAnchor.constraint(equalToConstant: 60),
            
            segmentedControl.topAnchor.constraint(equalTo: searchBarView.bottomAnchor, constant: 20),
            segmentedControl.leadingAnchor.constraint(equalTo: searchBarView.leadingAnchor),
            segmentedControl.trailingAnchor.constraint(equalTo: searchBarView.trailingAnchor),
            segmentedControl.heightAnchor.constraint(equalToConstant: 40),
            
            collectionView.topAnchor.constraint(equalTo: segmentedControl.bottomAnchor, constant: 20),
            collectionView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 20),
            collectionView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -20),
            collectionView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
        ])
        
    }
    
}



