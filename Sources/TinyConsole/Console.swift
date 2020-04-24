//
//  Console.swift
//  
//
//  Created by Roy Hsu on 2020/3/27.
//

// MARK: - Console

import SwiftUI
import TinyConsoleCore

#warning("TODO: [Priority: high] scroll to the bottom after the log display is updated.")
#warning("TODO: [Priority: high] log should be selectable and copyable.")
#warning("TODO: [Priority: high] it seems like a great idea if we set the default height of the console by percentage. e.g. 1/4 of the screen.")
struct Console<Embedded>: View where Embedded: View {
  @EnvironmentObject
  var logging: ConsoleLoggingStore

  private let embedded: Embedded

  private var foregroundToolbar: some View {
    ZStack {
      HStack {
        Text("Console")
          .font(.system(.headline))
          .padding()
        Spacer()
        HStack {
          Button(action: logging.clearDisplay) {
            #if os(macOS)
            Text("Clear")
              .foregroundColor(Color.black)
            #elseif os(iOS)
            Image(systemName: "trash.fill")
              .foregroundColor(Color.black)
            #endif
          }
        }
          .padding()
      }
        .background(Color.yellow)
    }
  }

  private var foreground: some View {
    ZStack {
      Rectangle()
        .fill(Color.white)

      foregroundContent
    }
  }

  private var foregroundContent: some View {
    logging._deprecatedDisplay.isEmpty
      ? AnyView(
        VStack(spacing: 0.0) {
          Spacer()
          Text("Empty")
            .foregroundColor(Color.gray)
          Spacer()
        }
      )
      : AnyView(
        ScrollView(showsIndicators: true) {
          ZStack {
            Rectangle()
              .fill(Color.clear)

            HStack(spacing: 0.0) {
              Text(logging._deprecatedDisplay)
              Spacer()
            }
              .padding()
          }
        }
      )
  }

  var body: some View {
    VDrawer(
      background: {
        embedded
      },
      foreground: {
        foreground
          .edgesIgnoringSafeArea(.bottom)
      },
      handle: {
        foregroundToolbar
      }
    )
  }

  init(@ViewBuilder embedded: () -> Embedded) {
    self.embedded = embedded()
  }
}

// MARK: - Previews

struct Console_Previews: PreviewProvider {
  static var previews: some View {
    Console {
      Rectangle()
        .fill(Color.purple)
    }
      .environmentObject(ConsoleLoggingStore.default)
  }
}
