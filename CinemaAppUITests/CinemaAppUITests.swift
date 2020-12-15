//
//  CinemaAppUITests.swift
//  CinemaAppUITests
//
//  Created by katya.s on 14.12.2020.
//  Copyright © 2020 io pandacode. All rights reserved.
//

import XCTest

class CinemaAppUITests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // UI tests must launch the application that they test.
        let app = XCUIApplication()
        app.launch()
        
        let app = app2
        app.navigationBars["Upcoming movie (0)"].buttons["Home"].tap()
        
        let app2 = app
        app2/*@START_MENU_TOKEN@*/.staticTexts["Update all data from remote source"]/*[[".buttons[\"Update all data from remote source\"].staticTexts[\"Update all data from remote source\"]",".staticTexts[\"Update all data from remote source\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        
        let cell = app.tables.children(matching: .cell).element(boundBy: 0)
        cell.staticTexts["United States of America"].tap()
        app2/*@START_MENU_TOKEN@*/.buttons["Clear fields"]/*[[".scrollViews.buttons[\"Clear fields\"]",".buttons[\"Clear fields\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.staticTexts["Clear fields"].tap()
        app.navigationBars["Edit movie"].buttons["Upcoming movie (4)"].tap()
        cell.children(matching: .other).element(boundBy: 0).swipeLeft()
        

        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
}
