//
//  Forecast.swift
//  WeatherApp-MVVM
//
//  Created by Eken Özlü on 5.01.2024.
//

import Foundation

final class Forecast: Codable {
    let date: String
    let temperature: Int
    let weatherDescription: WeatherDescription
    let humidity: Int
    let windSpeed: Double
    var descriptionImageName : String {
        switch weatherDescription {
        case .clearSky:
            return "forecast_img_sun"
        case .cloudy:
            return "forecast_img_cloud"
        case .partlyCloudy:
            return "forecast_img_sunandcloud"
        case .rain:
            return "forecast_img_rain"
        case .rainShowers:
            return "forecast_img_heavyrain"
        case .rainy:
            return "forecast_img_rain"
        case .scatteredClouds:
            return "forecast_img_sunandcloud"
        case .sunny:
            return "forecast_img_sun"
        case .weatherDescriptionPartlyCloudy:
            return "forecast_img_sunandcloud"
        }
    }
    var prettyDateString : String {
        let inputDateFormatter = DateFormatter()
        inputDateFormatter.dateFormat = "yyyy-MM-dd"
        let inputDate = inputDateFormatter.date(from: date) ?? Date()
        let outputDateFormatter = DateFormatter()
        outputDateFormatter.dateFormat = "dd MMMM yyyy"
        return outputDateFormatter.string(from: inputDate)
    }

    enum CodingKeys: String, CodingKey {
        case date, temperature
        case weatherDescription = "weather_description"
        case humidity
        case windSpeed = "wind_speed"
    }

    init(date: String, temperature: Int, weatherDescription: WeatherDescription, humidity: Int, windSpeed: Double) {
        self.date = date
        self.temperature = temperature
        self.weatherDescription = weatherDescription
        self.humidity = humidity
        self.windSpeed = windSpeed
    }
}
