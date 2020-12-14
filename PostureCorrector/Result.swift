//
//  Result.swift
//  PostureCorrector
//
//  Created by Woochan Park on 2020/12/14.
//

import Foundation

class Result {
  
  public static let date: Date = Date()
  
  // SampleList that RaspberryPi passed
  public static var testResultList: [Result] = []
  
  private let date: Date
  private let type: PostureType
  
  enum PostureType: CaseIterable{
    case Correct
    case Bad1
    case Bad2
    case Bad3
    case Bad4
    case Bad5
  }
  
  init(date: Date, type postureType: PostureType) {
    self.date = date
    self.type = postureType
  }
  
  convenience init(type postureType: PostureType) {
    self.init(date: Date(), type: postureType)
  }
}

extension Result {
  
  var recordedDate: Date {
    self.date
  }
  var postureType: PostureType {
      self.type
  }
  
  static func makeUpSampleList(count: Int) {
    
    for index in 1...count {
      testResultList.append(Result(date:Date(timeInterval: TimeInterval(index), since: date), type: PostureType.allCases.randomElement()!))
    }
  }
}
