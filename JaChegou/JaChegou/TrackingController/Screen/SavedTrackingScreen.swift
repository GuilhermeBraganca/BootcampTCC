//
//  SavedTrackingScreen.swift
//  JaChegou
//
//  Created by MacBook on 03/09/24.
//

import UIKit

class SavedTrackingScreen: UIView {

    lazy var headerView: HeaderView = {
        let view = HeaderView(title: "", image: UIImage(named: "worldImage"))
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    init() {
        super.init(frame: .zero)
        backgroundColor = .customLightGray()
        addElements()
        configConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addElements() {
        addSubview(headerView)
    }
    
    func configConstraints() {
        NSLayoutConstraint.activate([
            
            headerView.topAnchor.constraint(equalTo: topAnchor),
            headerView.leadingAnchor.constraint(equalTo: leadingAnchor),
            headerView.trailingAnchor.constraint(equalTo: trailingAnchor),
            headerView.heightAnchor.constraint(equalToConstant: 200)
            
        ])
    }
}
