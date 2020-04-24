//
//  ConsoleLogHandler.swift
//  
//
//  Created by Roy Hsu on 2020/3/27.
//

import Logging

public struct ConsoleLogHandler: LogHandler {
  public let label: String
  public var logLevel = Logger.Level.lowerBound
  public var metadata = Logger.Metadata()
  private let _log: Log

  public init(label: String, log: @escaping Log) {
    self.label = label
    self._log = log
  }

  public subscript(metadataKey key: String) -> Logger.Metadata.Value? {
    get { metadata[key] }
    set { metadata[key] = newValue }
  }

  public func log(
    level: Logger.Level,
    message: Logger.Message,
    metadata newMetadata: Logger.Metadata?,
    file: String,
    function: String,
    line: UInt
  ) {
    if level < logLevel { return }
    
    _log(
      label,
      level,
      message,
      metadata.merging(newMetadata ?? [:], uniquingKeysWith: { _, new in new }),
      file,
      function,
      line
    )
  }
}

// MARK: - Log

extension ConsoleLogHandler {
  public typealias Log = (
    _ source: String,
    _ level: Logger.Level,
    _ message: Logger.Message,
    _ metadata: Logger.Metadata?,
    _ file: String,
    _ function: String,
    _ line: UInt
  ) -> Void
}
