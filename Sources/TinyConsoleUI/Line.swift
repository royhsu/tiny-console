//
//  Line.swift
//  
//
//  Created by Roy Hsu on 2020/4/24.
//

// MARK: - Line

import SwiftUI
import TinyConsoleCore

struct Line: View {
  @ObservedObject
  var log: LogStore
  
  var body: some View {
    Text(formattedMessage)
  }
}

extension Line {
  private var formattedMessage: String {
    "\(log.message)"
  }
}
