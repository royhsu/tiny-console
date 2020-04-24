//
//  EnvironmentValues+Logger.swift
//
//
//  Created by Roy Hsu on 2020/3/28.
//  
//

import Logging
import SwiftUI

extension EnvironmentValues {
  public var logger: Logger {
    get { self[LoggerKey.self] }
    set { self[LoggerKey.self] = newValue }
  }
}

// MARK: - LoggerKey

public struct LoggerKey: EnvironmentKey {
  public static var defaultValue: Logger {
    Logger(label: Bundle.main.bundleIdentifier ?? "com.unknown.App")
  }
}
