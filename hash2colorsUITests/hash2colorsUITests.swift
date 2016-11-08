//
//  hash2colorsUITests.swift
//  hash2colorsUITests
//
//  Created by Maxime on 08.11.16.
//  Copyright © 2016 Maxime. All rights reserved.
//

import XCTest

class hash2colorsUITests: XCTestCase {
        
    override func setUp() {
        super.setUp()
        
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        let app = XCUIApplication()
        app.launchArguments.append("ui-testing")
        app.launch()

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testAddHash() {
        let app = XCUIApplication()
        let btn = app.navigationBars["Add a hash"].buttons["Save"]
        XCTAssertFalse(btn.isEnabled)
        app.tables.children(matching: .cell).element(boundBy: 0).children(matching: .textView).element.typeText("a")
        XCTAssertTrue(btn.isEnabled)
        btn.tap()
        app.alerts["Saved !"].buttons["Dismiss"].tap()
    }
    
    func testColorDetails() {
        let app = XCUIApplication()
        app.tables.staticTexts["Color 0 :"].tap()
        let backBtn = app.navigationBars["Color detail"].buttons["Add a hash"]
        backBtn.tap()
        
        app.tables.staticTexts["Color 3 :"].tap()
        backBtn.tap()
    }
    
    func testListHash() {
        let app = XCUIApplication()
        let tabBarsQuery = app.tabBars
        let listButton = tabBarsQuery.buttons["List"]
        listButton.tap()
        let cell = app.tables.children(matching: .cell).element(boundBy: 0)
        XCTAssertFalse(cell.staticTexts["do not exist"].exists)
        let countBefore = app.tables.cells.count
        tabBarsQuery.buttons["Add"].tap()
        cell.children(matching: .textView).element.typeText("o")
        app.navigationBars["Add a hash"].buttons["Save"].tap()
        app.alerts["Saved !"].buttons["Dismiss"].tap()
        listButton.tap()
        XCTAssertTrue(cell.staticTexts["7a81af3e591ac713f81ea1efe93dcf36157d8376"].exists)
        let countAfter = app.tables.cells.count
        XCTAssertTrue(countBefore < countAfter)
    }
    
}
