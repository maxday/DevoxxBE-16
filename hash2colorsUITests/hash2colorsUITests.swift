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
        continueAfterFailure = false

        let app = XCUIApplication()
        app.launchArguments.append("ui-testing")
        app.launch()
    }
    
    override func tearDown() {
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
