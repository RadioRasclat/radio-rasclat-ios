//
//  RadioRasclatUITests.swift
//  RadioRasclatUITests
//
//  Created by Domenik Töfflinger on 03.12.20.
//

import XCTest

class RadioRasclatUITests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testPlayRecording() throws {
        // UI tests must launch the application that they test.
        let app = XCUIApplication()
        app.launch()
        
        let tabBar = app.tabBars["Tab Bar"]
        tabBar.buttons["Recordings"].tap()
        
        let scrollViewsQuery = app.scrollViews
        scrollViewsQuery.otherElements.buttons.firstMatch.tap()
        
        scrollViewsQuery.otherElements.containing(.button, identifier:"play.fill").children(matching: .image).element(boundBy: 0).tap()
    }
    
    func testPlayLive() throws {
        // UI tests must launch the application that they test.
        let app = XCUIApplication()
        app.launch()
        
        let tabBar = app.tabBars["Tab Bar"]
        tabBar.buttons["Live"].tap()
        app.scrollViews.otherElements.buttons["play.fill"].tap()
        app.scrollViews.otherElements.buttons["pause.fill"].tap()
        
    }
    
    func testSchedule() throws {
        // UI tests must launch the application that they test.
        let app = XCUIApplication()
        app.launch()
        
        let tabBar = app.tabBars["Tab Bar"]
        tabBar.buttons["Schedule"].tap()
        
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
