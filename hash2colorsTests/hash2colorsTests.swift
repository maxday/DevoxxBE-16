//
//  hash2colorsTests.swift
//  hash2colorsTests
//
//  Created by Maxime on 09/10/16.
//  Copyright © 2016 Maxime. All rights reserved.
//

import XCTest
@testable import hash2colors

class hash2colorsTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    func testHash2ColorItemInitIncorrectLength() {
        do {
            try _ = HashColorItem(hash: "toto")
            XCTFail("Should fail")
        }
        catch let e as HashColorItem.HashError {
            XCTAssertEqual(e, HashColorItem.HashError.IncorrectLength)
        }
        catch {
            XCTFail("Wrong error")
        }
    }
    
    func testHash2ColorItemInitNil() {
        do {
            try _ = HashColorItem(hash: nil)
            XCTFail("Should fail")
        }
        catch let e as HashColorItem.HashError {
            XCTAssertEqual(e, HashColorItem.HashError.Nil)
        }
        catch {
            XCTFail("Wrong error")
        }
    }
    
    func testHash2ColorItemInitOk() {
        do {
            let hashColorItem = try HashColorItem(hash: "aaaaaaaabbbbbbbbccccccccddddddddeeeeeeee")
            XCTAssertEqual(5, hashColorItem.getColors().count)
            
        }
        catch {
            XCTFail("Should not fail")
        }
    }
    
    func testColorItemToColor() {
        let colorItem = ColorItem(red: 255, green: 255, blue: 255, size: 0)
        var red: CGFloat = 0.0
        var green: CGFloat = 0.0
        var blue: CGFloat = 0.0
        var alpha: CGFloat = 0.0
        colorItem.toUIColor().getRed(&red, green: &green, blue: &blue, alpha: &alpha)
        XCTAssertEqual(1, red)
        XCTAssertEqual(1, green)
        XCTAssertEqual(1, blue)
        XCTAssertEqual(1, alpha)
    }
    
}
