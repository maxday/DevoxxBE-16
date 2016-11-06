//
//  hash2colorsTests.swift
//  hash2colorsTests
//
//  Created by Maxime on 06.11.16.
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
    
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    func testInitNil() {
        do {
            try _ = HashColorItem(hash: nil)
        } catch let e as HashColorItem.HashError {
            XCTAssertEqual(e, HashColorItem.HashError.Nil)
        } catch {
            XCTFail()
        }
    }
    
    func testInitLength() {
        do {
            try _ = HashColorItem(hash: "fkleékfél")
        } catch let e as HashColorItem.HashError {
            XCTAssertEqual(e, HashColorItem.HashError.IncorrectLength)
        } catch {
            XCTFail()
        }
    }
    
    func testCorrectColors() {
        do {
            let hash = try HashColorItem(hash: "aaaaaa00bbbbbb00cccccc00dddddd00eeeeee00")
            XCTAssertEqual(hash.getHexaColorsAsString(index: 0), "aaaaaa")
            XCTAssertEqual(hash.getHexaColorsAsString(index: 1), "bbbbbb")
            XCTAssertEqual(hash.getHexaColorsAsString(index: 2), "cccccc")
            XCTAssertEqual(hash.getHexaColorsAsString(index: 3), "dddddd")
            XCTAssertEqual(hash.getHexaColorsAsString(index: 4), "eeeeee")

        } catch {
            XCTFail()
        }
    }
    
    func testAddHash() {
        let testHash = "aaaaaa00bbbbbb00cccccc00dddddd00eeeeee00"
        let addResource = HashColorItem.add(baseUrl:"http://127.0.0.1:8080", hashString:testHash)
        let expectationTest = expectation(description: "add a hash")
        Webservice().load(resource:addResource) { result in
            XCTAssertEqual(result, testHash)
            expectationTest.fulfill()
        }
        waitForExpectations(timeout: 10, handler: nil)
    }
    
//    public init(hash: String?) throws {
//        guard let hash = hash else {
//            throw HashError.Nil
//        }
//        if hash.characters.count != 40 {
//            throw HashError.IncorrectLength
//        }
//        self.hashString = hash
//        self.colors = extractColors()
//        self.size = sumColorSizes()
//    }
//    
}
