//
//  LogEditor.swift
//  Examples
//
//  Created by Roy Hsu on 2020/3/27.
//  Copyright © 2020 TinyWorld. All rights reserved.
//

import SwiftUI
import TinyConsoleCore
import TinyConsoleUI

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
      metadata: [
        "product": [
          "id": "1",
          "title": "sunt aut facere repellat provident occaecati excepturi optio reprehenderit",
          "body": "quia et suscipit\nsuscipit recusandae consequuntur expedita et cum\nreprehenderit molestiae ut ut quas totam\nnostrum rerum est autem sunt rem eveniet architecto",
          "userId": "1",
        ]
      ]
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
