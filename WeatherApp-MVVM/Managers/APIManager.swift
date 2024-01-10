//
//  APIManager.swift
//  WeatherApp-MVVM
//
//  Created by Eken Özlü on 5.01.2024.
//

import Foundation

//MARK: - API Manager Protocol
protocol APIManagerProtocol : AnyObject {
    func createRequest(with paramaters : [String : Any]) -> URLRequest?
    func fetchWeathers(of count : Int, completion : @escaping (_ weatherArr: [Weather]?, _ networkStatus: Bool?, _ error: ErrorType?) -> Void)
    func searchWeather(by text : String, completion : @escaping (_ weatherArr: [Weather]?, _ networkStatus: Bool?, _ errorDescription: ErrorType?) -> Void)
    func getWeatherDetail(by id : String, completion : @escaping (_ weather: Weather?, _ networkStatus: Bool?, _ errorDescription: ErrorType?) -> ())
}

//MARK: - APIManager
final class APIManager : APIManagerProtocol{
    
    //Base URL
    private let baseURL = "https://freetestapi.com/api/v1/weathers"
    
    //Variable for page counting
    private var itemsPerPage = 10
    
    //Internal function for generating request for each function
    internal func createRequest(with paramaters : [String : Any]) -> URLRequest? {
        var urlComponents = URLComponents(string: baseURL)
        var queryItems : [URLQueryItem] = []
        
        for (key,value) in paramaters {
            if let encodedValue = "\(value)".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) {
                let queryItem = URLQueryItem(name: key, value: encodedValue)
                queryItems.append(queryItem)
            }
        }
        
        urlComponents?.queryItems = queryItems
        if let url = urlComponents?.url {
            var request = URLRequest(url: url)
            request.httpMethod = "GET"
            return request
        } else {
            return nil
        }
    }
    
    ///This function fetchs weather data from API or cached data according to network connection.
    ///
    ///> Parameters:
    ///> "of count : Int" should be the current fetched data before call.
    ///
    ///> Returns:
    ///>Function returns 3 elements in completion,
    ///>Each of them is optional. Function checks for internet connection and returns online or cached data. Or an customized error for each scenario
    func fetchWeathers(of count : Int, completion : @escaping (_ weatherArr: [Weather]?, _ networkStatus: Bool?, _ error: ErrorType?) -> Void) {
        let currentPage : Int = (count / itemsPerPage) + 1
        let limit = itemsPerPage * currentPage
        
        if ConnectionManager.shared.isDeviceConnectedToNetwork() {
            if let request = createRequest(with: ["limit" : limit]) {
                let dataTask = URLSession.shared.dataTask(with: request) { data, response, error in
                    if error != nil {
                        completion(nil,true,.unableToFetchFromNetwork)
                    } else if let data = data {
                        let weatherArr = try? JSONDecoder().decode([Weather].self, from: data)
                        if currentPage == 1 {
                            CoreDataManager.shared.cacheOrUpdateFirst10ToCoreData(by: weatherArr ?? []) {
                                completion(weatherArr!,true,nil)
                            }
                        }
                        completion(weatherArr!,true,nil)
                    }
                }
                dataTask.resume()
            } else {
                completion(nil,true,.unableToFetchFromNetwork)
            }
        }
        else {
            if let objects = CoreDataManager.shared.fetchCachedWeathers() {
                var weatherArr : [Weather] = []
                if objects.isEmpty {
                    completion(nil,false,.emptyCoreData)
                } else {
                    for object in objects {
                        let weather = Weather(id: Int(object.value(forKey: "id") as? String ?? "-1")!,
                                              city: object.value(forKey: "city")  as? String ?? "N/A",
                                              country: object.value(forKey: "country")  as? String ?? "N/A",
                                              latitude: 0.0,
                                              longitude: 0.0,
                                              temperature: object.value(forKey: "temperature")  as? Double ?? 0.0,
                                              weatherDescription: WeatherDescription(rawValue: object.value(forKey: "weatherDescription") as? String ?? "") ?? .sunny,
                                              humidity: 0,
                                              windSpeed: 0.0,
                                              forecast: [])
                        weatherArr.append(weather)
                    }
                    completion(weatherArr,false,nil)
                }
            } else {
                completion(nil,false,.unableToFetchFromCoreData)
            }
        }
    }
    
    ///This function fetchs weather data from API according to search text. API returns the cities according to name contains the text or not.
    ///
    ///> Parameters:
    ///> "by text : String" should be the search text
    ///
    ///> Returns:
    ///>Function returns 3 elements in completion,
    ///>Each of them is optional. Function checks for internet connection and returns online result data. Or an customized error for each scenario
    func searchWeather(by text : String, completion : @escaping (_ weatherArr: [Weather]?, _ networkStatus: Bool?, _ error: ErrorType?) -> Void) {
        if let request = createRequest(with: ["search" : text]),
           ConnectionManager.shared.isDeviceConnectedToNetwork() {
            let dataTask = URLSession.shared.dataTask(with: request) { data, response, error in
                if error != nil {
                    completion(nil,true,.unableToFetchFromNetwork)
                } else if let data = data {
                    let weatherArr = try? JSONDecoder().decode([Weather].self, from: data)
                    completion(weatherArr!,true,nil)
                }
            }
            dataTask.resume()
        } else {
            completion(nil,false,.noConnection)
        }
    }
    
    ///This function fetchs single weather data from API.
    ///
    ///> Parameters:
    ///> "by id : String" should be the id of the desired data
    ///
    ///> Returns:
    ///>Function returns 3 elements in completion,
    ///>Each of them is optional. Function checks for internet connection and returns online result data. Or an customized error for each scenario
    func getWeatherDetail(by id : String, completion : @escaping (_ weather: Weather?, _ networkStatus: Bool?, _ error: ErrorType?) -> ()) {
        if ConnectionManager.shared.isDeviceConnectedToNetwork(),
           let urlString = URL(string: "\(baseURL)/\(id)"){
            let dataTask = URLSession.shared.dataTask(with: urlString) { data, response, error in
                if error != nil {
                    completion(nil,true,.unableToFetchFromNetwork)
                } else if let data = data {
                    let weather = try? JSONDecoder().decode(Weather.self, from: data)
                    completion(weather!,true,nil)
                }
            }
            dataTask.resume()
        } else {
            completion(nil,false,.noConnection)
        }
    }
}
