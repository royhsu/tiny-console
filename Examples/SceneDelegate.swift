//
//  SceneDelegate.swift
//  Examples
//
//  Created by Roy Hsu on 2020/3/27.
//  Copyright © 2020 TinyWorld. All rights reserved.
//

import Logging
import SwiftUI
import TinyConsoleCore
import UIKit

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
      // 3. Don't forget inject the default console store.
      let contentView = AllExamples()
        .environmentObject(console)
      let window = UIWindow(windowScene: windowScene)

      window.rootViewController = UIHostingController(rootView: contentView)
      window.makeKeyAndVisible()
      self.window = window
    }
  }
}
