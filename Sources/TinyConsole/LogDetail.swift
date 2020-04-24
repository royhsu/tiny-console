//
//  LogDetail.swift
//  
//
//  Created by Roy Hsu on 2020/4/24.
//

import SwiftUI
import TinyConsoleCore
import TreeCore
import TreeUI

struct LogDetail: View {
  private let log: Log
  @ObservedObject
  var subtree: SubtreeStore<Atomic>
  
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
          subtree,
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

extension LogDetail {
  init(log: Log) {
    self.init(
      log: log,
      subtree:SubtreeStore(
        value: .string("metadata"),
        children: Primitive(metadata: log.metadata)
      )
    )
  }
}
