//
//  RadioRasclatUITests.swift
//  RadioRasclatUITests
//
//  Created by Domenik printmedia on 13.05.20.
//  Copyright © 2020 Domenik Toefflinger. All rights reserved.
//

import XCTest

class RadioRasclatUITests: XCTestCase {
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testAppLaunch() {
        // UI tests must launch the application that they test.
        let app = XCUIApplication()
        app.launch()
    }

    func testLiveButtons() {
        // UI tests must launch the application that they test.
        let app = XCUIApplication()
        app.launch()

        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.

        app.buttons["btn play"].tap()
        app.buttons["btn pause"].tap()
    }

    func testBroadcasts() {
        // UI tests must launch the application that they test.
        let app = XCUIApplication()
        app.launch()

        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        
        app.tabBars.buttons["Broadcasts"].tap()
        app.tables/*@START_MENU_TOKEN@*/.staticTexts["Radio Rasclat presents: Fruity Loup • Vol.2 (24.04.2020)"]/*[[".cells.staticTexts[\"Radio Rasclat presents: Fruity Loup • Vol.2 (24.04.2020)\"]",".staticTexts[\"Radio Rasclat presents: Fruity Loup • Vol.2 (24.04.2020)\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app.buttons["btn play"].tap()
    }

    func testLaunchPerformance() {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTOSSignpostMetric.applicationLaunch]) {
                XCUIApplication().launch()
            }
        }
    }
}
