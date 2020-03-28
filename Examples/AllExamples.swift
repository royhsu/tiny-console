//
//  Examples.swift
//  Examples
//
//  Created by Roy Hsu on 2020/3/27.
//  Copyright © 2020 TinyWorld. All rights reserved.
//

import Logging
import SwiftUI
import TinyConsoleCore
import TinyConsoleSwiftLog

struct AllExamples: View {
  @EnvironmentObject
  var logging: ConsoleLoggingStore
  
  private var examples = [
    Example(title: "Basics", body: AnyView(BasicsExample())),
    Example(
      title: "Integrate with SwiftLog",
      body: AnyView(IntegrateSwiftLogExample())),
  ]
  
  var body: some View {
    NavigationView {
      List(examples) { example in
        NavigationLink(
          destination: example
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
    let logging = ConsoleLoggingStore()
    
    LoggingSystem.bootstrap { label in
      ConsoleLogHandler(label: label, log: logging.write)
    }
    
    return AllExamples()
      .environmentObject(logging)
  }
}
