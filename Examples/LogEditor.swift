//
//  LogEditor.swift
//  Examples
//
//  Created by Roy Hsu on 2020/3/27.
//  Copyright © 2020 TinyWorld. All rights reserved.
//

import Logging
import SwiftUI
import TinyConsole
import TinyConsoleCore

struct LogEditor: View {
  @State
  private var message = ""
  @EnvironmentObject
  var logging: ConsoleLoggingStore
  @Environment(\.logger)
  var logger

  var body: some View {
    Form {
      Section {
        TextField("Message", text: $message)
      }
      Section {
        HStack {
          Spacer()
          Button(action: log) {
            Text("Log")
          }
          Spacer()
        }
      }
        .disabled(message.isEmpty)
    }
  }

  private func log() {
    logger.trace(
      "\(message)",
      metadata: ["id":"1"]
    )
  }
}

// MARK: - Previews

struct LogEditor_Previews: PreviewProvider {
  static var previews: some View {
    LogEditor()
      .console(enabled: true)
      .environmentObject(ConsoleLoggingStore.default)
  }
}
