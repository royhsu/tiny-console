//
//  Log.swift
//  
//
//  Created by Roy Hsu on 2020/6/27.
//

import Logging

struct LogConfiguration {}

import SwiftUI

protocol PrimitiveLogStyle {
  associatedtype Body: View
  
  typealias Configuration = LogConfiguration
  
  func makeBody(configuration: Configuration) -> Body
}

struct Log {
  var source: String
  var level: Logger.Level
  var message: Logger.Message
  var metadata: [String: String]
  var file: String
  var function: String
  var line: Int
}
