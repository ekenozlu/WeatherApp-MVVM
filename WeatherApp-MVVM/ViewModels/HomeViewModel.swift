//
//  HomeViewModel.swift
//  WeatherApp-MVVM
//
//  Created by Eken Özlü on 5.01.2024.
//

import Foundation

protocol HomeViewModelProtocol : AnyObject {
    func updateWeatherTV(with networkStatus : Bool)
    func showStartEmptyView()
    func showSearchEmptyView()
}

final class HomeViewModel {
    
    private let apiManager : APIManagerProtocol
    
    init(apiManager: APIManagerProtocol) {
        self.apiManager = apiManager
    }
    
    public var delegate : HomeViewModelProtocol?
    
    public var weatherArr : [Weather] = []
    public var reachedBottom : Bool = false
    public var loadCheck : Bool = false
    
    func fetchWeathers() {
        apiManager.fetchWeathers(of: weatherArr.count) { [self] weatherArr, networkStatus, error in
            if error != nil {
                delegate?.showStartEmptyView()
            } else if weatherArr != nil , networkStatus == true {
                self.weatherArr = weatherArr!
                if weatherArr!.isEmpty {
                    delegate?.showStartEmptyView()
                } else {
                    delegate?.updateWeatherTV(with: networkStatus!)
                }
            } else if weatherArr != nil , networkStatus == false {
                self.weatherArr = weatherArr!
                delegate?.updateWeatherTV(with: networkStatus!)
            }
        }
    }
    
    func refreshWeatherData() {
        apiManager.fetchWeathers(of: 0) { [self] weatherArr, networkStatus, error in
            if error != nil {
                delegate?.showStartEmptyView()
            } else if weatherArr != nil , networkStatus == true {
                self.weatherArr = weatherArr!
                if weatherArr!.isEmpty {
                    delegate?.showStartEmptyView()
                } else {
                    delegate?.updateWeatherTV(with: networkStatus!)
                }
            } else if weatherArr != nil , networkStatus == false {
                delegate?.updateWeatherTV(with: networkStatus!)
            }
        }
    }
    
    func searchWeather(by name : String) {
        apiManager.searchWeather(by: name) { [self] weatherArr, networkStatus, error in
            if error != nil {
                delegate?.showSearchEmptyView()
            } else if weatherArr != nil , networkStatus == true {
                self.weatherArr = weatherArr!
                if weatherArr!.isEmpty {
                    delegate?.showSearchEmptyView()
                } else {
                    delegate?.updateWeatherTV(with: networkStatus!)
                }
            } else if weatherArr != nil , networkStatus == false {
                delegate?.updateWeatherTV(with: networkStatus!)
            }
        }
    }
    
}
