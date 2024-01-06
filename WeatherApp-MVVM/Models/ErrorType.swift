//
//  ErrorTypes.swift
//  WeatherApp-MVVM
//
//  Created by Eken Özlü on 6.01.2024.
//

import Foundation

enum ErrorType : String {
    case noConnection = "You don't have network connection"
    case unableToFetchFromNetwork = "Unable to fetch data from network"
    case unableToFetchFromCoreData = "Unable to fetch previously cached data"
    case emptyCoreData = "There is no previously cached data"
}
