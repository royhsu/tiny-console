//
//  ContentView.swift
//  Examples
//
//  Created by Roy Hsu on 2020/3/27.
//  Copyright © 2020 TinyWorld. All rights reserved.
//

import SwiftUI
import TinyConsole
import TinyConsoleCore

struct ContentView: View {
  @EnvironmentObject
  var logging: ConsoleLoggingStore
  
  var body: some View {
    Console {
      LogInput(log: log)
    }
      .environmentObject(logging)
  }
  
  private func log(message: String) { logging.write(message) }
}

// MARK: - Previews

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
      .environmentObject(ConsoleLoggingStore())
  }
}
