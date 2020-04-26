# TinyConsole

TinyConsole allows you to embed console into an app, happy debugging. It's quite useful
to use in-app console when working with SwiftUI live preview or debugging on real devices.

## Installation

### Swift Package Manager

Add the package to your dependencies.

```swift
.package(url: "https://github.com/royhsu/tiny-console.git", .branch("master")),
```

## Usages

To understand how TinyConsole works, you must look at ConsoleStore. It's the 
source of truth for consoles. 

Since TinyConsole relies on SwiftLog to integrate different logging services, make sure you have understood how to use [SwiftLog](https://github.com/apple/swift-log).

The following snippet demonstrates how to bootstrap our ConsoleStore as a logging service at the beginning of an app.

```swift
import Logging
import TinyConsoleCore

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
  var window: UIWindow?

  func scene(
    _ scene: UIScene,
    willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions
  ) {
    // 1. Get the default console store.
    let console = ConsoleStore.default

    // 2. Register the default console store into the logging system.
    LoggingSystem.bootstrap { label in
      ConsoleLogHandler(label: label, log: console.log)
    }

    if let windowScene = scene as? UIWindowScene {

      let contentView = ContentView()
        .console(enabled: true) // 3. Embed your content view with a console by using console(enabled:) modifier.
        .environmentObject(console) // 4. Don't forget inject the default console store by using environmentObject(_:) modifier.
      let window = UIWindow(windowScene: windowScene)

      window.rootViewController = UIHostingController(rootView: contentView)
      window.makeKeyAndVisible()
      self.window = window
    }
  }
}
```

Now, it's time to log some message! You can get a `logger` from environment values.

```swift
import TinyConsoleCore
import TinyConsoleUI

struct ContentView: View {
  @EnvironmentObject
  var console: ConsoleStore
  @Environment(\.logger) // 1. Get a logger from environment values.
  var logger

  var body: some View {
    Button(action: log) {
      Text("Log")
    }
  }

  func log() {
    // 2. Log your message!
    logger.trace("Hello World")
  }
}
```

### Notes

Since it always causes a crash when we bootstrap ConsoleStore instances for 
different Previews like the following example, so ConsoleStore is defined as a 
singleton to avoid framework users hitting this issue.

It's possible to lift the limitation (allowing user to initialize their own console stores) in the 
future if we find a solution for this problem.

```swift
struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    // Custom console stores in different places cause the problem.
    let console = ConsoleStore()

    // `bootstrap(_:)` must be called only once.
    LoggingSystem.bootstrap { label in
      ConsoleLogHandler(label: label, log: console.log)
    }

    return ContentView()
      .environmentObject(console)
  }
}
```
