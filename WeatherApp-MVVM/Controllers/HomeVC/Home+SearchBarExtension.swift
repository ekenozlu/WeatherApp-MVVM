//
//  Home+SearchBarExtension.swift
//  WeatherApp-MVVM
//
//  Created by Eken Özlü on 5.01.2024.
//

import UIKit

extension HomeVC : UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if let text = searchBar.text, !text.isEmpty {
            viewModel.searchWeather(by: searchText)
        } else if searchBar.text == "" {
            viewModel.fetchWeathers()
        }
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        viewModel.fetchWeathers()
    }
}
