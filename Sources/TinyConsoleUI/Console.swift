//
//  Console.swift
//  
//
//  Created by Roy Hsu on 2020/3/27.
//

// MARK: - Console

import SwiftUI
import TinyConsoleCore
import TinyTreeCore
import TinyTreeUI

#warning("TODO: [Priority: high] scroll to the bottom after the log display is updated.")
#warning("TODO: [Priority: high] log should be selectable and copyable.")
#warning("TODO: [Priority: high] it seems like a great idea if we set the default height of the console by percentage. e.g. 1/4 of the screen.")
struct Console<Embedded>: View where Embedded: View {
  @EnvironmentObject
  var console: ConsoleStore
  @Environment(\.logger)
  private var logger
  private let embedded: Embedded
  @ObservedObject
  private var drag = DragStore()
  private var foreground: some View {
    NavigationView {
      ZStack {
        Rectangle()
          .fill(Color.white)
        foregroundContent
      }
        .navigationBarTitle("Console", displayMode: .inline)
        .navigationBarItems(
          trailing: Button(action: console.clearDisplay) {
            clear
              .foregroundColor(Color.black)
          }
        )
    }
      .shadow(radius: 1.0)
      .gesture(
        DragGesture()
          .onChanged { self.drag.translation = $0.translation }
      )
  }
  private var foregroundContent: some View {
    console.display.isEmpty
      ? AnyView(placeholder)
      : AnyView(
        List(console.display) { log in
          NavigationLink(
            destination: LogDetail(log: log)
              .navigationBarTitle("Inspector")
          ) {
            Line(log: log)
          }
        }
      )
  }
  var body: some View {
    VDrawer(
      drag: drag,
      background: {
        embedded
      },
      foreground: {
        foreground
          .edgesIgnoringSafeArea(.bottom)
      }
    )
  }

  init(@ViewBuilder embedded: () -> Embedded) {
    self.embedded = embedded()
  }
}

extension Console {
  /// The image for clear button.
  private var clear: some View {
    #if os(macOS)
    return AnyView(Text("Clear"))
    #elseif os(iOS)
    return AnyView(
      Image(systemName: "trash")
        .imageScale(.medium)
    )
    #endif
  }
  /// The placeholder when console is empty.
  private var placeholder: some View {
    VStack {
      Spacer()
      Text("Empty")
        .foregroundColor(Color.gray)
      Spacer()
    }
  }
}

// MARK: - Previews

struct Console_Previews: PreviewProvider {
  static var previews: some View {
    ConsoleStore.default.log(
      from: "com.example.Demo",
      level: .trace,
      message: "Products fetched!",
      metadata: [
        "products": [
          [
            "userId": "1",
            "id": "1",
            "title": "sunt aut facere repellat provident occaecati excepturi optio reprehenderit",
            "body": "quia et suscipit\nsuscipit recusandae consequuntur expedita et cum\nreprehenderit molestiae ut ut quas totam\nnostrum rerum est autem sunt rem eveniet architecto",
          ],
          [
            "userId": "1",
            "id": "2",
            "title": "qui est esse",
            "body": "est rerum tempore vitae\nsequi sint nihil reprehenderit dolor beatae ea dolores neque\nfugiat blanditiis voluptate porro vel nihil molestiae ut reiciendis\nqui aperiam non debitis possimus qui neque nisi nulla",
          ]
        ],
      ],
      file: #file,
      function: #function,
      line: #line
    )
    
    return Console {
      Rectangle()
        .fill(Color.purple)
    }
      .environmentObject(ConsoleStore.default)
  }
}
