//
//  LoggerLevel+Bounds.swift
//  
//
//  Created by Roy Hsu on 2020/4/24.
//

import Logging

extension Logger.Level {
  /// The lowest level.
  static var lowerBound: Logger.Level {
    allCases.first!
  }
  /// The highest level.
  static var upperBound: Logger.Level {
    allCases.last!
  }
}
