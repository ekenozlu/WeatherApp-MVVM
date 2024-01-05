//
//  FavsViewModel.swift
//  WeatherApp-MVVM
//
//  Created by Eken Özlü on 5.01.2024.
//

import Foundation

protocol FavsViewModelDelegate {
    func updateFavsTV()
    func showUnableToFetchView()
    func showNoFavsView()
}

final class FavsViewModel {
    
    public var delegate : FavsViewModelDelegate?
    
    public var favsArr : [Weather] = []
    
    func fetchFavsFromCoreData() {
        if let objects = CoreDataManager.shared.fetchFavsFromCoreData() {
            favsArr.removeAll()
            if objects.isEmpty {
                delegate?.showNoFavsView()
            } else {
                for object in objects {
                    let weather = Weather(id: Int(object.value(forKey: "id") as? String ?? "-1")!,
                                          city: object.value(forKey: "city") as? String ?? "N/A",
                                          country: object.value(forKey: "country")  as? String ?? "N/A",
                                          latitude: 0.0,
                                          longitude: 0.0,
                                          temperature: object.value(forKey: "temperature")  as? Double ?? 0.0,
                                          weatherDescription: WeatherDescription(rawValue: object.value(forKey: "weatherDescription") as? String ?? "") ?? .sunny,
                                          humidity: 0,
                                          windSpeed: 0.0,
                                          forecast: [])
                    favsArr.append(weather)
                    delegate?.updateFavsTV()
                }
            }
        } else {
            delegate?.showUnableToFetchView()
        }
    }
}
