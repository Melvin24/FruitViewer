//
//  HTTPURLResponse+ResponseTypeTests.swift
//  FruitViewerTests

import XCTest
@testable import FruitViewer

class HTTPURLResponseResponseTypeSuccessTests: XCTestCase {
    
    func testLowerBounds() {
        let response = makeResponse(statusCode: 100)
        XCTAssertTrue(response.responseType == .success)
    }
    
    func testUpperBounds() {
        let response = makeResponse(statusCode: 299)
        XCTAssertTrue(response.responseType == .success)
    }
    
    func testOutOfBounds() {
        let response = makeResponse(statusCode: 300)
        XCTAssertTrue(response.responseType != .success)
    }
    
}

class HTTPURLResponseResponseTypeRedirectionTests: XCTestCase {
    
    var response: HTTPURLResponse!
    
    func testLowerBounds() {
        let response = makeResponse(statusCode: 300)
        XCTAssertTrue(response.responseType == .redirection)
    }
    
    func testUpperBounds() {
        let response = makeResponse(statusCode: 399)
        XCTAssertTrue(response.responseType == .redirection)
    }
    
    func testOutOfBounds() {
        let response = makeResponse(statusCode: 400)
        XCTAssertTrue(response.responseType != .redirection)
    }
    
}

class HTTPURLResponseResponseTypeClientErrorTests: XCTestCase {
    
    func testLowerBounds() {
        let response = makeResponse(statusCode: 400)
        XCTAssertTrue(response.responseType == .clientError)
    }
    
    func testUpperBounds() {
        let response = makeResponse(statusCode: 499)
        XCTAssertTrue(response.responseType == .clientError)
    }
    
    func testOutOfBounds() {
        let response = makeResponse(statusCode: 500)
        XCTAssertTrue(response.responseType != .clientError)
    }
    
}

class HTTPURLResponseResponseTypeServerErrorTests: XCTestCase {
    
    func testLowerBounds() {
        let response = makeResponse(statusCode: 500)
        XCTAssertTrue(response.responseType == .serverError)
    }
    
    func testUpperBounds() {
        let response = makeResponse(statusCode: 599)
        XCTAssertTrue(response.responseType == .serverError)
    }
    
    func testOutOfBounds() {
        let response = makeResponse(statusCode: 600)
        XCTAssertTrue(response.responseType != .serverError)
    }
    
}

class HTTPURLResponseResponseTypeUndefinedTests: XCTestCase {
    
    func testOutOfBoundsLower() {
        let response = makeResponse(statusCode: 99)
        XCTAssertTrue(response.responseType == .undefined)
    }
    
    func testOutOfBoundsUpper() {
        let response = makeResponse(statusCode: 600)
        XCTAssertTrue(response.responseType == .undefined)
    }
    
}

func makeResponse(statusCode: Int) -> HTTPURLResponse {
    return HTTPURLResponse(url: URL(string: "example.url")!, statusCode: statusCode, httpVersion: nil, headerFields: nil)!
}
