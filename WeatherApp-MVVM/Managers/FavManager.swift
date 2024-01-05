//
//  FavManager.swift
//  WeatherApp-MVVM
//
//  Created by Eken Özlü on 5.01.2024.
//

import Foundation

protocol FavManagerDelegate {
    func addToFavs(weather : Weather)
    func removeFromFavs(weather : Weather)
}

final class FavManager : FavManagerDelegate{
    
    
    func addToFavs(weather: Weather) {
        
    }
    
    func removeFromFavs(weather: Weather) {
        
    }
    
    
    
}
