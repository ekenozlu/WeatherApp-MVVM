//
//  HomeViewModel.swift
//  WeatherApp-MVVM
//
//  Created by Eken Özlü on 5.01.2024.
//

import Foundation

protocol HomeViewModelDelegate {
    func updateWeatherTV()
    func showStartEmptyView()
    func showSearchEmptyView()
}

final class HomeViewModel {
    
    private let apiManager : APIManager
    
    init(apiManager: APIManager) {
        self.apiManager = apiManager
    }
    
    public var delegate : HomeViewModelDelegate?
    
    public var weatherArr : [Weather] = []
    public var reachedBottom : Bool = false
    public var loadCheck : Bool = false
    
    func fetchWeathers() {
        apiManager.fetchWeathers(of: weatherArr.count) { result in
            switch result {
            case .success(let array):
                self.weatherArr = array
                if self.weatherArr.isEmpty {
                    self.delegate?.showStartEmptyView()
                } else {
                    self.delegate?.updateWeatherTV()
                }
            case .failure(let error):
                self.delegate?.showStartEmptyView()
                print(error.localizedDescription)
            }
        }
    }
    
    func searchWeather(by name : String) {
        apiManager.searchWeather(by: name) { result in
            switch result {
            case .success(let array):
                self.weatherArr = array
                if self.weatherArr.isEmpty {
                    self.delegate?.showSearchEmptyView()
                } else {
                    self.delegate?.updateWeatherTV()
                }
            case .failure(let error):
                self.delegate?.showSearchEmptyView()
                print(error.localizedDescription)
            }
        }
    }
    
    
    
}
