//
//  ConsoleLoggingStore.swift
//  
//
//  Created by Roy Hsu on 2020/3/27.
//

import Combine

public final class ConsoleLoggingStore: ObservableObject {
  /// Current displayed lines.
  @Published
  public private(set) var display = ""

  /// All written lines.
  @Published
  private(set) var history = [String]()
}

extension ConsoleLoggingStore {
  /// Write new line into the store.
  public func write(_ line: String) {
    history.append(line)
    display = display.isEmpty ? line : (display + "\n" + line)
  }

  /// Clear all displayed lines.
  public func clearDisplay() { display = "" }
}

extension ConsoleLoggingStore {
  public static let `default` = ConsoleLoggingStore()
}
