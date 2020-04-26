//
//  ConsoleModifier.swift
//
//
//  Created by Roy Hsu on 2020/3/28.
//
//

import SwiftUI
import TinyConsoleCore

struct ConsoleModifier: ViewModifier {
  @EnvironmentObject
  var console: ConsoleStore
  var enabled: Bool

  func body(content: Content) -> some View {
    enabled
      ? AnyView(
        Console {
          content
        }
      )
      : AnyView(content)
  }
}

extension View {
  /// Automatic wrapping content within a console and passing console store to environment objects.
  ///
  /// - Parameter enabled: Whether to enable the console. The console should be enabled in DEBUG
  /// only, but not in RELEASE mode.
  /// - Returns: Console-wrapped view.
  public func console(enabled: Bool) -> some View {
    modifier(ConsoleModifier(enabled: enabled))
  }
}
