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
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testInitNil() {
        do {
            try _ = ColorScheme(hash: nil)
            XCTFail()
        } catch let e as ColorScheme.HashError {
            XCTAssertEqual(e, ColorScheme.HashError.Nil)
        } catch {
            XCTFail()
        }
    }
    
    func testInitLength() {
        do {
            try _ = ColorScheme(hash: "not a valid hash")
            XCTFail()
        } catch let e as ColorScheme.HashError {
            XCTAssertEqual(e, ColorScheme.HashError.IncorrectLength)
        } catch {
            XCTFail()
        }
    }
    
    func testInitOK() {
        do {
            let colorScheme = try ColorScheme(hash: "aaaaaa10bbbbbb20cccccc30dddddd40eeeeee50")
            XCTAssertEqual(colorScheme.getColors()[0].getColorAsString(), "aaaaaa")
            XCTAssertEqual(colorScheme.getColors()[1].getColorAsString(), "bbbbbb")
            XCTAssertEqual(colorScheme.getColors()[2].getColorAsString(), "cccccc")
            XCTAssertEqual(colorScheme.getColors()[3].getColorAsString(), "dddddd")
            XCTAssertEqual(colorScheme.getColors()[4].getColorAsString(), "eeeeee")
        } catch {
            XCTFail()
        }
    }
    
    func testAddHash() {
        let hash = "86f7e437faa5a7fce15d1ddcb9eaeaea377667b8"
        let addResource = ColorScheme.add(baseUrl: "http://127.0.0.1:8080", hashString: hash)
        let expect = expectation(description: "add a hash")
        Webservice().load(resource: addResource) { result in
            XCTAssertEqual(result, hash)
            expect.fulfill()
        }
        waitForExpectations(timeout: 10, handler: nil)
        
    }
    
}
