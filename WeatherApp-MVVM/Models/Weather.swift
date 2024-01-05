//
//  Weather.swift
//  WeatherApp-MVVM
//
//  Created by Eken Özlü on 5.01.2024.
//

import Foundation

final class Weather: Codable {
    let id: Int
    let city, country: String
    let latitude, longitude, temperature: Double
    let weatherDescription: WeatherDescription
    let humidity: Int
    let windSpeed: Double
    let forecast: [Forecast]
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

    enum CodingKeys: String, CodingKey {
        case id, city, country, latitude, longitude, temperature
        case weatherDescription = "weather_description"
        case humidity
        case windSpeed = "wind_speed"
        case forecast
    }

    init(id: Int, city: String, country: String, latitude: Double, longitude: Double, temperature: Double, weatherDescription: WeatherDescription, humidity: Int, windSpeed: Double, forecast: [Forecast]) {
        self.id = id
        self.city = city
        self.country = country
        self.latitude = latitude
        self.longitude = longitude
        self.temperature = temperature
        self.weatherDescription = weatherDescription
        self.humidity = humidity
        self.windSpeed = windSpeed
        self.forecast = forecast
    }
}

enum WeatherDescription: String, Codable {
    case clearSky = "Clear sky"
    case cloudy = "Cloudy"
    case partlyCloudy = "Partly cloudy"
    case rain = "Rain"
    case rainShowers = "Rain showers"
    case rainy = "Rainy"
    case scatteredClouds = "Scattered clouds"
    case sunny = "Sunny"
    case weatherDescriptionPartlyCloudy = "Partly Cloudy"
}


