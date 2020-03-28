# TinyConsole

TinyConsole allows you to embed the console into an app, happy debugging.

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
