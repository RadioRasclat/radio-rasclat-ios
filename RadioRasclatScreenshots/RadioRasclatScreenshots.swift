//
//  RadioRasclatScreenshots.swift
//  RadioRasclatScreenshots
//
//  Created by Domenik Töfflinger on 18.12.20.
//

import XCTest

class RadioRasclatScreenshots: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func takeScreenshots() throws {
        // UI tests must launch the application that they test.
        let app = XCUIApplication()
        app.launch()
        setupSnapshot(app)
        
        snapshot("0Live")
        
        app.tabBars["Tab Bar"].buttons["Recordings"].tap()
        
        snapshot("1Recordings")
        
        let scrollViewsQuery = app.scrollViews
        scrollViewsQuery.otherElements.buttons.firstMatch.tap()
        
        snapshot("2RecordingsDetail")
        
        app.tabBars["Tab Bar"].buttons["Schedule"].tap()
        
        snapshot("3Schedule")

        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
}
