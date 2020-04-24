//
//  Examples.swift
//  Examples
//
//  Created by Roy Hsu on 2020/3/27.
//  Copyright © 2020 TinyWorld. All rights reserved.
//

import SwiftUI
import TinyConsoleCore

struct AllExamples: View {
  @EnvironmentObject
  var logging: ConsoleLoggingStore

  private var examples = [
    Example(
      title: "Basics",
      body: AnyView(
        LogEditor()
          .console(enabled: true)
      )
    ),
  ]

  var body: some View {
    NavigationView {
      List(examples) { example in
        NavigationLink(
          destination:
            example
            .navigationBarTitle("\(example.title)", displayMode: .inline)
        ) {
          Text(example.title)
        }
      }
        .navigationBarTitle("Examples")
    }
  }
}

// MARK: - Previews

struct ALLExamples_Previews: PreviewProvider {
  static var previews: some View {
    AllExamples()
      .environmentObject(ConsoleLoggingStore.default)
  }
}
