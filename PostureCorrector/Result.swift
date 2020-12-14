//
//  Result.swift
//  PostureCorrector
//
//  Created by Woochan Park on 2020/12/14.
//

import Foundation

class Result {
  
  // SampleList that RaspberryPi passed
  public static let testResultList: [Result] = []
  
  private let date: Date
  private let type: PostureType
  
  enum PostureType: String {
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
  var postureType: PostureType {
      self.type
  }
}
