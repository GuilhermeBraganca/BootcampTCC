//
//  HomeControllerScreen.swift
//  JaChegou
//
//  Created by MacBook on 11/08/24.
//

import Foundation
import UIKit

class HomeControllerScreen: UIView {
    
    lazy var headerView: HeaderView = {
        let view = HeaderView(title: "Rastreamentos", image: UIImage(named: "worldImage"))
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
      view.backgroundColor = .white
      view.layer.cornerRadius = 30
      // sombra
      view.layer.shadowColor = UIColor.black.cgColor
      view.layer.shadowOpacity = 0.1
      view.layer.shadowOffset = CGSize(width: 0, height: 2)
      view.layer.shadowRadius = 8
      return view
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
        //addSubview(trackingLabel)
        addSubview(searchBarView)
        
    }
    
    func configConstraints(){
        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: topAnchor),
            headerView.leadingAnchor.constraint(equalTo: leadingAnchor),
            headerView.trailingAnchor.constraint(equalTo: trailingAnchor),
            headerView.heightAnchor.constraint(equalToConstant: 200),
            
//            trackingLabel.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: 20),
//            trackingLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
//            trackingLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            
            searchBarView.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: 16),
            searchBarView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            searchBarView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            searchBarView.heightAnchor.constraint(equalToConstant: 60),

            
        ])
        
    }
    
    
}
