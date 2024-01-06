//
//  WeatherApp_MVVMUITests.swift
//  WeatherApp-MVVMUITests
//
//  Created by Eken Özlü on 5.01.2024.
//

import XCTest

final class WeatherApp_MVVMUITests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func test_OpenFirstWeather_FavouriteIt_OpenItFromFavsTab_UnfavouriteIt() throws {
        // UI tests must launch the application that they test.
        
        let app = XCUIApplication()
        app.launch()
        let newYorkStaticText = app.tables/*@START_MENU_TOKEN@*/.staticTexts["New York"]/*[[".cells.staticTexts[\"New York\"]",".staticTexts[\"New York\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        newYorkStaticText.tap()
        app.buttons["favorite"].tap()
        app.navigationBars["WeatherApp_MVVM.DetailVC"].buttons["Back"].tap()
        app.tabBars["Tab Bar"].buttons["Favourites"].tap()
        newYorkStaticText.tap()
        app.buttons["favorite"].tap()
        let backButton = app.navigationBars["Favs"].buttons["Back"]
        backButton.tap()
    }
    
    func test_SearchWeatherToronto_GoBack_CancelSearch() throws {
        // UI tests must launch the application that they test.
        
        let app = XCUIApplication()
        app.launch()
        
        let worldWeatherNavigationBar = app.navigationBars["World Weather"]
        worldWeatherNavigationBar.searchFields["Search For Place"].tap()
        
        
        let TKey = app.keys["T"]
        TKey.tap()
        
        let oKey = app.keys["o"]
        oKey.tap()
        
        let rKey = app.keys["r"]
        rKey.tap()
        
        oKey.tap()
        
        let nKey = app.keys["n"]
        nKey.tap()
        
        let tKey2 = app.keys["t"]
        tKey2.tap()
        
        oKey.tap()
        
        app.buttons["Search"].tap()
        
        app.tables.staticTexts["24.3°C"].tap()
        
        app.navigationBars["WeatherApp_MVVM.DetailVC"].buttons["Back"].tap()
        
        worldWeatherNavigationBar.buttons["Cancel"].tap()
    }

    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
}
