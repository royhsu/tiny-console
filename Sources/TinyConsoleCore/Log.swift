//
//  Log.swift
//  
//
//  Created by Roy Hsu on 2020/4/24.
//

import Foundation
import Logging

public struct Log {
  public let id = UUID()
  /// A label for which generates the log.
  public var source: String
  public var level: Logger.Level
  public var message: Logger.Message
  public var metadata: Logger.Metadata
  public var file: String
  public var function: String
  public var line: UInt
}

// MARK: - Identifiable

extension Log: Identifiable {}

// MARK: - Metadata

extension Log {
  subscript(metadataKey: Logger.Metadata.Key) -> Logger.Metadata.Value? {
    get { metadata[metadataKey] }
    set { metadata[metadataKey] = newValue }
  }
}
