//
//  HomeControllerViewController.swift
//  JaChegou
//
//  Created by MacBook on 11/08/24.
//

import UIKit


class HomeControllerViewController: UIViewController {

  var screen: HomeControllerScreen?
  var viewModel: ListViewModel = ListViewModel()

  override func loadView() {
    screen = HomeControllerScreen()
    view = screen
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    screen?.delegate = self
    screen?.configTableViewProtocols(delegate: self, dataSource: self)
  }
}

extension HomeControllerViewController: HomeControllerScreenProtocol {
  func changeTrackingType(type: TrackingType) {
    viewModel.setNewTrackingType(newType: type)
    screen?.trackingTableView.reloadData()
  }
}

extension HomeControllerViewController: UITableViewDelegate, UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return viewModel.numberOfRowsInSection
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: TrackingTableViewCell.identifier, for: indexPath) as? TrackingTableViewCell
    cell?.setupCell(track: viewModel.loadCurrentDetail(indexPath: indexPath))
    return cell ?? UITableViewCell()
  }
}
