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
        
        
        

        let app = XCUIApplication()
        app.launchArguments.append("ui-testing")
        app.launch()
    
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
        
        
        let colorLabel0 = cellColor0.staticTexts.element(boundBy: 0)
        let colorHashLabel0 = cellColor0.staticTexts.element(boundBy: 1)
        
        let colorLabel1 = cellColor1.staticTexts.element(boundBy: 0)
        let colorHashLabel1 = cellColor1.staticTexts.element(boundBy: 1)
        
        let colorLabel2 = cellColor2.staticTexts.element(boundBy: 0)
        let colorHashLabel2 = cellColor2.staticTexts.element(boundBy: 1)
        
        
        
        XCTAssertEqual("Color 0 :", colorLabel0.label)
        XCTAssertEqual("#86f7e4", colorHashLabel0.label)
        
        XCTAssertEqual("Color 1 :", colorLabel1.label)
        XCTAssertEqual("#faa5a7", colorHashLabel1.label)
        
        XCTAssertEqual("Color 2 :", colorLabel2.label)
        XCTAssertEqual("#e15d1d", colorHashLabel2.label)
        
               
    }
    
    func testExample2() {
        
        let app = XCUIApplication()
        let tablesQuery = app.tables
        let textView = tablesQuery.children(matching: .cell).element(boundBy: 0).children(matching: .textView).element
        textView.tap()
        
        textView.typeText("a")
        textView.typeText("b")
        textView.typeText("c")
        
        tablesQuery.staticTexts["Color 0 :"].tap()
        app.navigationBars["Color detail"].buttons["Add a hash"].tap()
        
        tablesQuery.staticTexts["Color 1 :"].tap()
        app.navigationBars["Color detail"].buttons["Add a hash"].tap()
        
        tablesQuery.staticTexts["Color 2 :"].tap()
        app.navigationBars["Color detail"].buttons["Add a hash"].tap()
        
        tablesQuery.staticTexts["Color 3 :"].tap()
        app.navigationBars["Color detail"].buttons["Add a hash"].tap()
        
        tablesQuery.staticTexts["Color 4 :"].tap()
        app.navigationBars["Color detail"].buttons["Add a hash"].tap()
    }
    

    
    func testOK() {
        let app = XCUIApplication()
        
        
        let str = randomString(length: 10)
        
        let tabBarsQuery = app.tabBars
        let tablesQuery = app.tables
        
        tabBarsQuery.buttons["List"].tap()
        let currentCount = tablesQuery.cells.count
        
        tabBarsQuery.buttons["Add"].tap()
        
        let textView = app.tables.children(matching: .cell).element(boundBy: 0).children(matching: .textView).element
        textView.tap()
        
        textView.typeText(str)
            
        app.navigationBars["Add a hash"].buttons["Save"].tap()

        tabBarsQuery.buttons["List"].tap()
        
        XCTAssertEqual(UInt(1)+currentCount, (tablesQuery.cells.count))
        
    }
    
    func test4() {
    
        XCUIApplication().tabBars.buttons["List"].tap()
    }
       
    
    func randomString(length: Int) -> String {
        
        let letters : NSString = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        let len = UInt32(letters.length)
        
        var randomString = ""
        
        for _ in 0 ..< length {
            let rand = arc4random_uniform(len)
            var nextChar = letters.character(at: Int(rand))
            randomString += NSString(characters: &nextChar, length: 1) as String
        }
        
        return randomString
    }
    
    
    
}
