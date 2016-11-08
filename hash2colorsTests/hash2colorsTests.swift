//
//  hash2colorsTests.swift
//  hash2colorsTests
//
//  Created by Maxime on 08.11.16.
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
        XCTAssertTrue(true)
    }
    
    func testInitNil() {
        do {
            try _ = HashColorItem(hash: nil)
            XCTFail()
        } catch let e as HashColorItem.HashError {
            XCTAssertEqual(e, HashColorItem.HashError.Nil)
        } catch {
            XCTFail()
        }
    }
    
    func testInitLength() {
        do {
            try _ = HashColorItem(hash: "not a valid hash")
            XCTFail()
        } catch let e as HashColorItem.HashError {
            XCTAssertEqual(e, HashColorItem.HashError.IncorrectLength)
        } catch {
            XCTFail()
        }
    }
    
    func testInitOK() {
        do {
            let hash = try HashColorItem(hash: "aaaaaa10bbbbbb20cccccc30dddddd40eeeeee50")
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
        let hash = "86f7e437faa5a7fce15d1ddcb9eaeaea377667b8"
        let addResource = HashColorItem.add(baseUrl: "http://127.0.0.1:8080", hashString: hash)
        let expect = expectation(description: "add a hash")
        Webservice().load(resource: addResource) { result in
            XCTAssertEqual(result, hash)
            expect.fulfill()
        }
        waitForExpectations(timeout: 10, handler: nil)
        
    }
    
}
