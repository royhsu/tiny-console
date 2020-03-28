//
//  IntegrateSwiftLogExample.swift
//  Examples
//
//  Created by Roy Hsu on 2020/3/27.
//  Copyright © 2020 TinyWorld. All rights reserved.
//

import Logging
import SwiftUI
import TinyConsole
import TinyConsoleCore
import TinyConsoleSwiftLog

struct IntegrateSwiftLogExample: View {
  @EnvironmentObject
  var logging: ConsoleLoggingStore
  @Environment(\.logger)
  var logger

  var body: some View {
    Console {
      LogInput(log: log)
    }
  }
  
  private func log(message: String) { logger.trace("\(message)") }
}

// MARK: - Previews

struct IntegrateSwiftLogExample_Previews: PreviewProvider {
  static var previews: some View {
    let logging = ConsoleLoggingStore()
    
    LoggingSystem.bootstrap { label in
      ConsoleLogHandler(label: label, log: logging.write)
    }
    
    return IntegrateSwiftLogExample()
      .environmentObject(logging)
  }
}
