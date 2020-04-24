//
//  Log.swift
//  
//
//  Created by Roy Hsu on 2020/4/24.
//

import Logging

struct Log {
  /// A label for which generates the log.
  var source: String
  var level: Logger.Level
  var message: Logger.Message
  var metadata: Logger.Metadata
  var file: String
  var function: String
  var line: UInt
}

extension Log {
  subscript(metadataKey: Logger.Metadata.Key) -> Logger.Metadata.Value? {
    get { metadata[metadataKey] }
    set { metadata[metadataKey] = newValue }
  }
}

