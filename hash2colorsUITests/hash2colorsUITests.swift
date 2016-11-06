//
//  hash2colorsUITests.swift
//  hash2colorsUITests
//
//  Created by Maxime on 09/10/16.
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
        XCUIApplication().launch()

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        
        let app = XCUIApplication()
        let tablesQuery = app.tables
        let textView = tablesQuery.children(matching: .cell).element(boundBy: 0).children(matching: .textView).element
        
        textView.tap()
        textView.typeText("a")

        XCTAssertEqual(1, app.tables.count)
        let hash2colorsTable = app.tables.element(boundBy: 0)
        
        XCTAssertEqual(8, hash2colorsTable.cells.count)
        
        let cellColor0 = hash2colorsTable.cells.element(boundBy: 3)
        XCTAssertEqual(2, cellColor0.staticTexts.count)
        let cellColor1 = hash2colorsTable.cells.element(boundBy: 4)
        XCTAssertEqual(2, cellColor1.staticTexts.count)
        let cellColor2 = hash2colorsTable.cells.element(boundBy: 5)
        XCTAssertEqual(2, cellColor2.staticTexts.count)
        let cellColor3 = hash2colorsTable.cells.element(boundBy: 6)
        XCTAssertEqual(2, cellColor3.staticTexts.count)
        let cellColor4 = hash2colorsTable.cells.element(boundBy: 7)
        XCTAssertEqual(2, cellColor4.staticTexts.count)
        
        let colorLabel0 = cellColor0.staticTexts.element(boundBy: 0)
        let colorHashLabel0 = cellColor0.staticTexts.element(boundBy: 1)
        
        let colorLabel1 = cellColor1.staticTexts.element(boundBy: 0)
        let colorHashLabel1 = cellColor1.staticTexts.element(boundBy: 1)
        
        let colorLabel2 = cellColor2.staticTexts.element(boundBy: 0)
        let colorHashLabel2 = cellColor2.staticTexts.element(boundBy: 1)
        
        let colorLabel3 = cellColor3.staticTexts.element(boundBy: 0)
        let colorHashLabel3 = cellColor3.staticTexts.element(boundBy: 1)
        
        let colorLabel4 = cellColor4.staticTexts.element(boundBy: 0)
        let colorHashLabel4 = cellColor4.staticTexts.element(boundBy: 1)
        
        XCTAssertEqual("Color 0 :", colorLabel0.label)
        XCTAssertEqual("#86f7e4", colorHashLabel0.label)
        
        XCTAssertEqual("Color 1 :", colorLabel1.label)
        XCTAssertEqual("#faa5a7", colorHashLabel1.label)
        
        XCTAssertEqual("Color 2 :", colorLabel2.label)
        XCTAssertEqual("#e15d1d", colorHashLabel2.label)
        
        XCTAssertEqual("Color 3 :", colorLabel3.label)
        XCTAssertEqual("#b9eaea", colorHashLabel3.label)
        
        XCTAssertEqual("Color 4 :", colorLabel4.label)
        XCTAssertEqual("#377667", colorHashLabel4.label)
        
    }
    
}
