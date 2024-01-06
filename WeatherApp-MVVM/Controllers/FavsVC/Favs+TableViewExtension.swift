//
//  Favs+TableViewExtension.swift
//  WeatherApp-MVVM
//
//  Created by Eken Özlü on 6.01.2024.
//

import UIKit

extension FavsVC : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.favsArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: WeatherTableViewCell.cellIdentifier, for: indexPath) as? WeatherTableViewCell else {
            return UITableViewCell()
        }
        let object = viewModel.favsArr[indexPath.row]
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
            let viewModel = DetailViewModel(apiManager: apiManager, selectedWeatherID: "\(viewModel.favsArr[indexPath.row].id)")
            let vc = DetailVC(viewModel: viewModel)
            vc.hidesBottomBarWhenPushed = true
            self.navigationController?.pushViewController(vc, animated: true)
        } else {
            AlertManager.shared.showAlert(in: self, title: "Connection Failed", message: "We are unable to show details with cached datas", btnText: "OK")
        }
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let unfavAction = UIContextualAction(style: .normal, title: "Remove from Favs") { [self] _, view, completionHandler in
            CoreDataManager.shared.deleteFav(by: "\(viewModel.favsArr[indexPath.row].id)") { [self] result in
                viewModel.fetchFavsFromCoreData()
                completionHandler(result)
            }
        }
        unfavAction.image = UIImage(systemName: "star.slash")
        unfavAction.backgroundColor = .clrSecondaryPurple
        
        return UISwipeActionsConfiguration(actions: [unfavAction])
    }
    
    @objc func refreshTableView() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) { [self] in
            viewModel.fetchFavsFromCoreData()
        }
    }
    
}
