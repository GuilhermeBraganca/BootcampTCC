//
//  SavedTrackingViewController.swift
//  JaChegou
//
//  Created by MacBook on 03/09/24.
//

import UIKit

class SavedTrackingViewController: UIViewController {

    var screen: SavedTrackingScreen?
    var SavedTrackingList: SavedTrackingViewModel = SavedTrackingViewModel()
    
    override func loadView() {
        screen = SavedTrackingScreen()
        view = screen
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //screen?.delegate = self
        screen?.configTableViewProtocols(delegate: self, dataSource: self)
    }

}

extension SavedTrackingViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        SavedTrackingList.numberOfRowsInSection
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SavedTrackingTableViewCell.identifier, for: indexPath) as? SavedTrackingTableViewCell
        cell?.setupCell(track: SavedTrackingList.loadCurrentDetail(indexPath: indexPath))
        return cell ?? UITableViewCell()
    }
    
    
}
