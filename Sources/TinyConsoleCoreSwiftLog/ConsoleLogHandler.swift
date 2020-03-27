//
//  ConsoleLogHandler.swift
//  
//
//  Created by Roy Hsu on 2020/3/27.
//

import Logging

public struct ConsoleLogHandler: LogHandler {
  public let label: String
  public var logLevel = Logger.Level.trace
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
    #warning("TODO: [Priority: high] determine whether to show metadata.")
    let finalMetadata: Logger.Metadata
    if let newMetadata = newMetadata {
      finalMetadata = metadata.merging(
        newMetadata,
        uniquingKeysWith: { _, new in new }
      )
    } else { finalMetadata = metadata }
    #warning("TODO: [Priority: medium] add ConsoleLogFormatter.")
    let formattedText = "\(timestamp()) \(level) \(label): \(message)"
    _log(formattedText)
  }

  #warning("TODO: [Priority: high] unimplemented.")
  private func timestamp() -> String { "#Timestamp#" }
}

// MARK: - Log

extension ConsoleLogHandler {
  public typealias Log = (_ formattedText: String) -> Void
}
