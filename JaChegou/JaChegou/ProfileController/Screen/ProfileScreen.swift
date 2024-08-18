//
//  ProfileScreen.swift
//  JaChegou
//
//  Created by MacBook on 11/08/24.
//

import UIKit

class ProfileScreen: UIView {
    
    lazy var headerView: HeaderView = {
        
        let view = HeaderView(title: "Perfil", image: UIImage(named: "worldImage"))
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
     lazy var personalInformationLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Informações pessoais"
        label.font = UIFont.boldSystemFont(ofSize: 15)
        return label
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
            addSubview(personalInformationLabel)
        }
        
        func configConstraints() {
            NSLayoutConstraint.activate([
                headerView.topAnchor.constraint(equalTo: topAnchor),
                headerView.leadingAnchor.constraint(equalTo: leadingAnchor),
                headerView.trailingAnchor.constraint(equalTo: trailingAnchor),
                headerView.heightAnchor.constraint(equalToConstant: 200),
                
                personalInformationLabel.topAnchor.constraint(equalTo: topAnchor),
                personalInformationLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
                personalInformationLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
                personalInformationLabel.heightAnchor.constraint(equalToConstant: 600),
            ])
        }
    }
    

