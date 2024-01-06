//
//  DetailViewModel.swift
//  WeatherApp-MVVM
//
//  Created by Eken Özlü on 5.01.2024.
//

import Foundation

protocol DetailViewModelDelegate : AnyObject {
    func updateWeatherInformation(weather : Weather)
    func setButton(selected bool : Bool)
    func showFetchError()
}

final class DetailViewModel {
    
    private let apiManager : APIDelegate
    private let selectedWeatherID : String
    
    init(apiManager: APIDelegate, selectedWeatherID: String!) {
        self.apiManager = apiManager
        self.selectedWeatherID = selectedWeatherID
    }
    
    public var delegate : DetailViewModelDelegate?
    public var selectedWeather : Weather!
    
    func getWeatherDetails() {
        apiManager.getWeatherDetail(by: selectedWeatherID) { [self] weather, networkStatus, error in
            if error == nil, networkStatus == true, weather != nil {
                selectedWeather = weather
                delegate?.updateWeatherInformation(weather: selectedWeather)
            } else {
                delegate?.showFetchError()
            }
        }
    }
    
    func checkForButtonStatus() {
        delegate?.setButton(selected: CoreDataManager.shared.isWeatherFavourited(id: selectedWeatherID))
    }
    
    func addWeatherToFavs() {
        CoreDataManager.shared.addToFavsCoreData(weather: selectedWeather) { [self] result in
            if result {
                delegate?.setButton(selected: true)
            } else {
                delegate?.setButton(selected: false)
            }
        }
    }
    
    func removeWeatherFromeFavs() {
        CoreDataManager.shared.deleteFav(by: "\(selectedWeather.id)") { [self] result in
            if result {
                delegate?.setButton(selected: false)
            } else {
                delegate?.setButton(selected: true)
            }
        }
    }
    
    
}
