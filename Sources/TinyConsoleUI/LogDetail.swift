//
//  LogDetail.swift
//  
//
//  Created by Roy Hsu on 2020/4/24.
//

import SwiftUI
import TinyConsoleCore
import TinyTreeCore
import TinyTreeUI

struct LogDetail: View {
  @ObservedObject
  var log: LogStore
  
  var body: some View {
    List {
      Section(header: Text("Information")) {
        Text("Source: \(log.source)")
        Text("Level: \(log.level.rawValue)")
        Text("File: \(log.file)")
        Text("Function: \(log.function)")
        Text("Line: \(log.line)")
      }
      Section(header: Text("Metadata")) {
        Subtree(
          log.metadata,
          content: { subtree in
            SubtreeProperty(subtree)
          },
          leaf: { leaf in
            LeafProperty(leaf)
          }
        )
      }
    }
  }
}

// MARK: - Previews

struct LogDetail_Previews: PreviewProvider {
  static var previews: some View {
    LogDetail(
      log: LogStore(
        source: "com.example.Demo",
        level: .trace,
        message: "Prodcut fetced!",
        metadata: [
          "id": "1",
          "name": "Chocolate Cake",
        ],
        file: #file,
        function: #function,
        line: #line
      )
    )
  }
}
