# TinyConsole

TinyConsole allows you to embed the console into an app, happy debugging.

## Installation

### Swift Package Manager

Add the package as your dependences.

```swift
.package(url: "https://github.com/royhsu/tiny-console.git", .branch("master")),
```

## Usages

To understand how TinyConsole works, you must look at ConsoleLoggingStore. It's the 
source of truth for consoles. 

### Basics

First, you can access the default logging store.

```swift
import TinyConsole
import TinyConsoleCore

ConsoleLoggingStore.default // the default logging store.
```

Embed your content view into a console with `console(enabled:)` modifier.

```swift
ContentView()
	.console(enabled: true) // embed with a console.
```
Next, don't forget to inject the logging store with `environmentObject(_:)` modifier.

```swift
ContentView()
	.console(enabled: true)
	.environmentObject(ConsoleLoggingStore.default) // inject the default logging store.
```
Now, you can log any message by calling `write(_:)` from the logging store, and messages will appear in the console.

```swift
ConsoleLoggingStore.default.write("Hello World")
```

### SwiftLog Integration

Learn more about [SwiftLog](https://github.com/apple/swift-log).

You can also integrate SwiftLog framework to provide multiple logging services via `TinyConsoleSwiftLog` module.

First, bootstrap your logging services at the beginning of your program. Take `SceneDelegate` as the example.

```swift
import Logging
import TinyConsoleCore
import TinyConsoleSwiftLog

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
  var window: UIWindow?

  func scene(
    _ scene: UIScene,
    willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions
  ) {
    // 1. Get the default logging store.
    let logging = ConsoleLoggingStore.default

    // 2. Register the default logging store into the logging system.
    LoggingSystem.bootstrap { label in
      ConsoleLogHandler(label: label, log: logging.write)
    }
    
    if let windowScene = scene as? UIWindowScene {
      // 3. Don't forget inject the default logging store.
      let contentView = ContentView()
      		.console(enabled: true)
      		.environmentObject(logging)
      let window = UIWindow(windowScene: windowScene)
      
      window.rootViewController = UIHostingController(rootView: contentView)
      window.makeKeyAndVisible()
      self.window = window
    }
  }
}
```
It's time to log some message! Instead of calling `write(:)`  directly from the default logging store, you should use `logger` from environment values.

```swift
import Logging
import TinyConsoleCore
import TinyConsoleSwiftLog

struct ContentView: View {
	@EnvironmentObject
 	var logging: ConsoleLoggingStore
	@Environment(\.logger) // Get logger from the environment values.
	var logger
	
	var body: some View {
		Button(action: log) {
			Text("Log")
		}
	}
	
	func log() { 
		// Log your message!
		logger.trace("Hello World")
	}
}
```

### Notes

Since it always causes a crash when we bootstrap ConsoleLoggingStore instances for 
different Previews like the following example, so ConsoleLoggingStore is defined as a 
singleton to avoid framework users hitting this issue.

It's possible to lift the limitation (allowing user to initialize their own logging stores) in the 
future if we find a solution for this problem.

```swift
struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    // Custom logging stores in different places cause the problem.
    let logging = ConsoleLoggingStore()

    // `bootstrap(_:)` must be called only once.
    LoggingSystem.bootstrap { label in
      ConsoleLogHandler(label: label, log: logging.write)
    }

    return IntegrateSwiftLogExample()
      .environmentObject(logging)
  }
}
```
