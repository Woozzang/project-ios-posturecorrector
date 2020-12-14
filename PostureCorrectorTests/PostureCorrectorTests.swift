//
//  PostureCorrectorTests.swift
//  PostureCorrectorTests
//
//  Created by Woochan Park on 2020/12/14.
//

import XCTest
@testable import PostureCorrector

class PostureCorrectorTests: XCTestCase {
  
  var result: Result!
  
  override func setUpWithError() throws {
      // Put setup code here. This method is called before the invocation of each test method in the class.
    result = Result(date: Date(), type: .Bad1)
  }

  override func tearDownWithError() throws {
      // Put teardown code here. This method is called after the invocation of each test method in the class.
  }

  func testExample() throws {
      // This is an example of a functional test case.
      // Use XCTAssert and related functions to verify your tests produce the correct results.
    result.date = Date(timeIntervalSinceNow: 83000)
    print(result.date)
  }

  func testPerformanceExample() throws {
      // This is an example of a performance test case.
      measure {
          // Put the code you want to measure the time of here.
      }
  }

}
