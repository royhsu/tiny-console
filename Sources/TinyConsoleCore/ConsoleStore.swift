//
//  ConsoleStore.swift
//  
//
//  Created by Roy Hsu on 2020/3/27.
//

import Combine
import Logging

public final class ConsoleStore: ObservableObject {
  private var logStream: AnyCancellable?
  /// A queue for logs to be piped into history.
  private let logQueue = PassthroughSubject<LogStore, Never>()
  /// Current displayed logs.
  @Published
  public private(set) var display = [LogStore]()
  /// All the logs are preserved in the history.
  @Published
  private var history = [LogStore]()
  
  init() { self.setUp() }
}

extension ConsoleStore {
  private func setUp() {
    logStream = logQueue.sink { [weak self] log in
      self?.history.append(log)
      self?.display.append(log)
    }
  }
}

extension ConsoleStore {
  public func log(
    from source: String,
    level: Logger.Level,
    message: Logger.Message,
    metadata: Logger.Metadata?,
    file: String,
    function: String,
    line: UInt
  ) {
    logQueue.send(
      LogStore(
        source: source,
        level: level,
        message: message,
        metadata: metadata ?? [:],
        file: file,
        function: function,
        line: line
      )
    )
  }

  /// Clear all displayed logs.
  public func clearDisplay() { display = [] }
}

extension ConsoleStore {
  public static let `default` = ConsoleStore()
}
