//
//  HomeVC+TableViewExtension.swift
//  WeatherApp-MVVM
//
//  Created by Eken Özlü on 5.01.2024.
//

import UIKit

extension HomeVC : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.weatherArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: WeatherTableViewCell.cellIdentifier, for: indexPath) as? WeatherTableViewCell else {
            return UITableViewCell()
        }
        let object = viewModel.weatherArr[indexPath.row]
        cell.cityLabel.text = object.city
        cell.countryLabel.text = object.country
        cell.degreeLabel.text = "\(object.temperature)°C"
        cell.descriptionLabel.text = object.weatherDescription.rawValue
        cell.forecastImageView.image = UIImage(named: object.descriptionImageName)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if ConnectionManager.shared.isDeviceConnectedToNetwork() {
            let apiManager = APIManager()
            let viewModel = DetailViewModel(apiManager: apiManager, selectedWeatherID: "\(viewModel.weatherArr[indexPath.row].id)")
            let vc = DetailVC(viewModel: viewModel)
            vc.hidesBottomBarWhenPushed = true
            self.navigationController?.pushViewController(vc, animated: true)
        } else {
            AlertManager.shared.showAlert(in: self, title: "Connection Failed", message: "We are unable to show details with cached datas", btnText: "OK")
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if let text = searchController.searchBar.text, !(text.isEmpty) {}
        else {
            let height = scrollView.frame.size.height
            let contentYOffset = scrollView.contentOffset.y
            let distanceFromBottom = scrollView.contentSize.height - contentYOffset
            
            if viewModel.loadCheck, !(viewModel.reachedBottom), distanceFromBottom < height {
                viewModel.reachedBottom = true
                loadingIndicator.isHidden = false
                loadingIndicator.startAnimating()
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.5, execute: {
                    self.viewModel.fetchWeathers()
                })
            }
        }
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let favAction = UIContextualAction(style: .normal, title: "Add to Favs") { [self] _, view, completionHandler in
            CoreDataManager.shared.addToFavsCoreData(weather: viewModel.weatherArr[indexPath.row]) { result in
                completionHandler(result)
            }
        }
        favAction.image = UIImage(systemName: "star.fill")
        favAction.backgroundColor = .clrSecondaryPurple
        
        let unfavAction = UIContextualAction(style: .normal, title: "Remove from Favs") { [self] _, view, completionHandler in
            CoreDataManager.shared.deleteFav(by: "\(viewModel.weatherArr[indexPath.row].id)") { result in
                completionHandler(result)
            }
        }
        unfavAction.image = UIImage(systemName: "star.slash")
        unfavAction.backgroundColor = .clrSecondaryPurple
        
        if CoreDataManager.shared.isWeatherFavourited(id: "\(viewModel.weatherArr[indexPath.row].id)") {
            return UISwipeActionsConfiguration(actions: [unfavAction])
        } else {
            return UISwipeActionsConfiguration(actions: [favAction])
        }
    }
    
    @objc func refreshTableView() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) { [self] in
            viewModel.refreshWeatherData()
        }
    }
}
