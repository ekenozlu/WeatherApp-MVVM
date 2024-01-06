//
//  WeatherApp_MVVMTests.swift
//  WeatherApp-MVVMTests
//
//  Created by Eken Özlü on 5.01.2024.
//

import XCTest
@testable import WeatherApp_MVVM

final class WeatherApp_MVVMTests: XCTestCase {
    
    private var mockAPIManager : MockAPIManager!
    private var homeViewModelTest : HomeViewModel!
    private var detailViewModelTest : DetailViewModel!
    private var homeDelegate : MockHomeViewModelDelegate!
    private var detailDelegate : MockDetailViewModelDelegate!

    override func setUpWithError() throws {
        mockAPIManager = MockAPIManager()
        homeViewModelTest = HomeViewModel(apiManager: mockAPIManager)
        homeDelegate = MockHomeViewModelDelegate()
        homeViewModelTest.delegate = homeDelegate
        
        detailViewModelTest = DetailViewModel(apiManager: mockAPIManager, selectedWeatherID: "")
        detailDelegate = MockDetailViewModelDelegate()
        detailViewModelTest.delegate = detailDelegate
    }

    override func tearDownWithError() throws {
        mockAPIManager = nil
        homeViewModelTest = nil
        homeDelegate = nil
        detailViewModelTest = nil
        detailDelegate = nil
    }

    func testFetchedWeather_whenHasConnectionAndAPISuccess_delegateBoolToggles() throws {
        let nilError : WeatherApp_MVVM.ErrorType? = nil
        let mockResult = ([Weather(id: 99, city: "", country: "",
                                   latitude: 0.0, longitude: 0.0, temperature: 0.0,
                                   weatherDescription: .sunny, humidity: 0, windSpeed: 0.0, forecast: [])],true,nilError)
        mockAPIManager.mockFetchResult = mockResult
        homeViewModelTest.fetchWeathers()
        XCTAssertEqual(homeDelegate.checkBool, true)
    }
    
    func testFetchedWeather_whenHasConnectionAndAPIFails_delegateBoolToggles() throws {
        let nilWeatherArr : [WeatherApp_MVVM.Weather]? = nil
        let mockResult = (nilWeatherArr,true,WeatherApp_MVVM.ErrorType.unableToFetchFromNetwork)
        mockAPIManager.mockFetchResult = mockResult
        homeViewModelTest.fetchWeathers()
        XCTAssertEqual(homeDelegate.checkBool, true)
    }
    
    func testFetchedWeather_whenDontHaveConnectionAndCoreDataFetchedSuccesfully_delegateBoolToggles() throws {
        let nilError : WeatherApp_MVVM.ErrorType? = nil
        let mockResult = ([Weather(id: 99, city: "", country: "",
                                   latitude: 0.0, longitude: 0.0, temperature: 0.0,
                                   weatherDescription: .sunny, humidity: 0, windSpeed: 0.0, forecast: [])],false,nilError)
        mockAPIManager.mockFetchResult = mockResult
        homeViewModelTest.fetchWeathers()
        XCTAssertEqual(homeDelegate.checkBool, true)
    }
    
    func testFetchedWeather_whenDontHaveConnectionAndCoreDataCouldntFetch_delegateBoolToggles() throws {
        let nilWeatherArr : [WeatherApp_MVVM.Weather]? = nil
        let mockResult = (nilWeatherArr,false,WeatherApp_MVVM.ErrorType.unableToFetchFromCoreData)
        mockAPIManager.mockFetchResult = mockResult
        homeViewModelTest.fetchWeathers()
        XCTAssertEqual(homeDelegate.checkBool, true)
    }
    
    func testFetchedWeather_whenDontHaveConnectionAndCoreDataIsEmpty_delegateBoolToggles() throws {
        let nilWeatherArr : [WeatherApp_MVVM.Weather]? = nil
        let mockResult = (nilWeatherArr,false,WeatherApp_MVVM.ErrorType.emptyCoreData)
        mockAPIManager.mockFetchResult = mockResult
        homeViewModelTest.fetchWeathers()
        XCTAssertEqual(homeDelegate.checkBool, true)
    }
    
    func testSearchWeather_whenHasConnectionAndAPISuccess_delegateBoolToggles() throws {
        let nilError : WeatherApp_MVVM.ErrorType? = nil
        let mockResult = ([Weather(id: 99, city: "", country: "",
                                   latitude: 0.0, longitude: 0.0, temperature: 0.0,
                                   weatherDescription: .sunny, humidity: 0, windSpeed: 0.0, forecast: [])],true,nilError)
        mockAPIManager.mockSearchResult = mockResult
        homeViewModelTest.searchWeather(by: "99")
        XCTAssertEqual(homeDelegate.checkBool, true)
    }
    
    func testSearchWeather_whenHasConnectionAndAPIFails_delegateBoolToggles() throws {
        let nilWeatherArr : [WeatherApp_MVVM.Weather]? = nil
        let mockResult = (nilWeatherArr,true,WeatherApp_MVVM.ErrorType.unableToFetchFromNetwork)
        mockAPIManager.mockSearchResult = mockResult
        homeViewModelTest.searchWeather(by: "")
        XCTAssertEqual(homeDelegate.checkBool, true)
    }
    
    func testSearchWeather_whenHasNoConnection_delegateBoolToggles() throws {
        let nilWeatherArr : [WeatherApp_MVVM.Weather]? = nil
        let mockResult = (nilWeatherArr,false,WeatherApp_MVVM.ErrorType.noConnection)
        mockAPIManager.mockSearchResult = mockResult
        homeViewModelTest.searchWeather(by: "")
        XCTAssertEqual(homeDelegate.checkBool, true)
    }
    
    func testDetailWeather_whenHasConnectionAndAPISuccess_delegateBoolToggles() throws {
        let nilError : WeatherApp_MVVM.ErrorType? = nil
        let mockResult = (Weather(id: 99, city: "", country: "",
                                  latitude: 0.0, longitude: 0.0, temperature: 0.0,
                                  weatherDescription: .sunny, humidity: 0, windSpeed: 0.0, forecast: []),true,nilError)
        mockAPIManager.mockDetailResult = mockResult
        detailViewModelTest.getWeatherDetails()
        XCTAssertEqual(detailDelegate.checkBool, true)
    }
    
    func testDetailWeather_whenHasConnectionAndAPIFails_delegateBoolToggles() throws {
        let nilWeather : WeatherApp_MVVM.Weather? = nil
        let mockResult = (nilWeather,true,WeatherApp_MVVM.ErrorType.unableToFetchFromNetwork)
        mockAPIManager.mockDetailResult = mockResult
        detailViewModelTest.getWeatherDetails()
        XCTAssertEqual(detailDelegate.checkBool, true)
    }
    
    func testDetailWeather_whenHasNoConnection_delegateBoolToggles() throws {
        let nilWeather : WeatherApp_MVVM.Weather? = nil
        let mockResult = (nilWeather,false,WeatherApp_MVVM.ErrorType.noConnection)
        mockAPIManager.mockDetailResult = mockResult
        detailViewModelTest.getWeatherDetails()
        XCTAssertEqual(detailDelegate.checkBool, true)
    }
}

class MockAPIManager : APIDelegate {
    var mockFetchResult : ([WeatherApp_MVVM.Weather]?, Bool?, WeatherApp_MVVM.ErrorType?)?
    var mockSearchResult : ([WeatherApp_MVVM.Weather]?, Bool?, WeatherApp_MVVM.ErrorType?)?
    var mockDetailResult : (WeatherApp_MVVM.Weather?, Bool?, WeatherApp_MVVM.ErrorType?)?
    
    func createRequest(with paramaters: [String : Any]) -> URLRequest? {
        return WeatherApp_MVVM.APIManager().createRequest(with: paramaters)
    }
    
    func fetchWeathers(of count: Int, completion: @escaping ([WeatherApp_MVVM.Weather]?, Bool?, WeatherApp_MVVM.ErrorType?) -> Void) {
        let parameters: [String: String] = ["key1": "value1", "key2": "value2"]
        let urlRequest = createRequest(with: parameters)
        XCTAssertNotNil(urlRequest, "URLRequest should not be nil")
        if let result = mockFetchResult {
            completion(result.0,result.1,result.2)
        }
    }
    
    func searchWeather(by text: String, completion: @escaping ([WeatherApp_MVVM.Weather]?, Bool?, WeatherApp_MVVM.ErrorType?) -> Void) {
        let parameters: [String: String] = ["key1": "value1", "key2": "value2"]
        let urlRequest = createRequest(with: parameters)
        XCTAssertNotNil(urlRequest, "URLRequest should not be nil")
        if let result = mockSearchResult {
            completion(result.0,result.1,result.2)
        }
    }
    
    func getWeatherDetail(by id: String, completion: @escaping (WeatherApp_MVVM.Weather?, Bool?, WeatherApp_MVVM.ErrorType?) -> ()) {
        let parameters: [String: String] = ["key1": "value1", "key2": "value2"]
        let urlRequest = createRequest(with: parameters)
        XCTAssertNotNil(urlRequest, "URLRequest should not be nil")
        if let result = mockDetailResult {
            completion(result.0,result.1,result.2)
        }
    }
}

class MockHomeViewModelDelegate : HomeViewModelDelegate {
    var checkBool : Bool = false
    func updateWeatherTV(with networkStatus: Bool) {
        checkBool = true
    }
    
    func showStartEmptyView() {
        checkBool = true
    }
    
    func showSearchEmptyView() {
        checkBool = true
    }
}

class MockDetailViewModelDelegate : DetailViewModelDelegate {
    var checkBool = false
    func updateWeatherInformation(weather: WeatherApp_MVVM.Weather) {
        checkBool = true
    }
    
    func setButton(selected bool: Bool) {
        checkBool = true
    }
    
    func showFetchError() {
        checkBool = true
    }
}
