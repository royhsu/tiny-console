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
            clear
              .foregroundColor(Color.black)
          }
        }
          .padding()
      }
        .background(Color.yellow)
    }
  }
  
  private var clear: some View {
    #if os(macOS)
    return AnyView(Text("Clear"))
    #elseif os(iOS)
    return AnyView(Image(systemName: "trash.fill"))
    #endif
  }

  private var foreground: some View {
    ZStack {
      Rectangle()
        .fill(Color.white)
      foregroundContent
    }
  }

  private var placeholder: some View {
    VStack {
      Spacer()
      Text("Empty")
        .foregroundColor(Color.gray)
      Spacer()
    }
  }
  
  private var foregroundContent: some View {
    logging.display.isEmpty
      ? AnyView(placeholder)
      : AnyView(
        List(logging.display) { log in
          NavigationLink(destination: Text("Metadata")) {
            Line(log: log)
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

// MARK: - Line

fileprivate struct Line: View {
  var log: Log
  private var formattedMessage: String {
    "\(log.message)"
  }
  
  var body: some View {
    Text(formattedMessage)
  }
  
  init(log: Log) {
    self.log = log
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
