//
//  BasicsExample.swift
//  Examples
//
//  Created by Roy Hsu on 2020/3/27.
//  Copyright © 2020 TinyWorld. All rights reserved.
//

import SwiftUI
import TinyConsole
import TinyConsoleCore

struct BasicsExample: View {
  @EnvironmentObject
  var logging: ConsoleLoggingStore
  
  var body: some View {
    LogInput(log: log)
  }
  
  private func log(message: String) { logging.write(message) }
}

// MARK: - Previews

struct BasicsExample_Previews: PreviewProvider {
  static var previews: some View {
    BasicsExample()
      .console(enabled: true)
      .environmentObject(ConsoleLoggingStore.default)
  }
}
