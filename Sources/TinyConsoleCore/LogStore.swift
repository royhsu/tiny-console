//
//  LogStore.swift
//  
//
//  Created by Roy Hsu on 2020/4/24.
//

import Combine
import Logging
import TinyTreeCore

public final class LogStore: ObservableObject {
  @Published
  public var source: String
  @Published
  public var level: Logger.Level
  @Published
  public var message: Logger.Message
  public let metadata: SubtreeStore<Atom>
  @Published
  public var file: String
  @Published
  public var function: String
  @Published
  public var line: UInt
  
  public init(
    source: String,
    level: Logger.Level,
    message: Logger.Message,
    metadata: Logger.Metadata,
    file: String,
    function: String,
    line: UInt
  ) {
    self.source = source
    self.level = level
    self.message = message
    self.metadata = SubtreeStore(
      value: .string("metadata"),
      children: Primitive(metadata: metadata)
    )
    self.file = file
    self.function = function
    self.line = line
  }
}

// MARK: - Identifiable

extension LogStore: Identifiable {}
