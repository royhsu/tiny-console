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
  @ObservedObject
  var subtree: SubtreeStore<Atomic>
  
  var body: some View {
    List {
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

extension LogDetail {
  init(log: Log) {
    self.init(
      subtree:SubtreeStore(
        value: .string("metadata"),
        children: Primitive(metadata: log.metadata)
      )
    )
  }
}
