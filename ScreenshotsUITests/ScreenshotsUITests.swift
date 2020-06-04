//
//  ScreenshotsUITests.swift
//  ScreenshotsUITests
//
//  Created by Domenik Töfflinger on 01.06.20.
//  Copyright © 2020 Domenik Toefflinger. All rights reserved.
//

import XCTest

class ScreenshotsUITests: XCTestCase {
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testStreamScreenshots() throws {
        // UI tests must launch the application that they test.
        let app = XCUIApplication()
        setupSnapshot(app)
        app.launch()

        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        let systemAlerts = XCUIApplication(bundleIdentifier: "com.apple.springboard").alerts
        if systemAlerts.buttons["Allow"].exists {
            systemAlerts.buttons["Allow"].tap()
        }
        snapshot("0Stream")
    }

    func testBroadcastsScreenshots() throws {
        // UI tests must launch the application that they test.
        let app = XCUIApplication()
        setupSnapshot(app)
        app.launch()

        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        let systemAlerts = XCUIApplication(bundleIdentifier: "com.apple.springboard").alerts
        if systemAlerts.buttons["Allow"].exists {
            systemAlerts.buttons["Allow"].tap()
        }
        app.tabBars.buttons["Broadcasts"].tap()
        snapshot("1Broadcasts")
    }

    func testBroadcastsDetailScreenshots() throws {
        // UI tests must launch the application that they test.
        let app = XCUIApplication()
        setupSnapshot(app)
        app.launch()

        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        let systemAlerts = XCUIApplication(bundleIdentifier: "com.apple.springboard").alerts
        if systemAlerts.buttons["Allow"].exists {
            systemAlerts.buttons["Allow"].tap()
        }
        
        app.tabBars.buttons["Broadcasts"].tap()
        app.tables/*@START_MENU_TOKEN@*/.staticTexts["Radio Rasclat presents: Fruity Loup • Vol.2 (24.04.2020)"]/*[[".cells.staticTexts[\"Radio Rasclat presents: Fruity Loup • Vol.2 (24.04.2020)\"]",".staticTexts[\"Radio Rasclat presents: Fruity Loup • Vol.2 (24.04.2020)\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        snapshot("2BroadcastsDetail")
    }
    
    func testScheduleScreenshots() {
        // UI tests must launch the application that they test.
        let app = XCUIApplication()
        setupSnapshot(app)
        app.launch()

        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        let systemAlerts = XCUIApplication(bundleIdentifier: "com.apple.springboard").alerts
        if systemAlerts.buttons["Allow"].exists {
            systemAlerts.buttons["Allow"].tap()
        }
        
        app.tabBars.buttons["Schedule"].tap()
        snapshot("3Schedule")
    }
}
