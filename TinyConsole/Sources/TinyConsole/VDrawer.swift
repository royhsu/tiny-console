//
//  VDrawer.swift
//  
//
//  Created by Roy Hsu on 2020/3/27.
//

import SwiftUI

#warning("TODO: [Priority: high] should set a maximum value for the top padding.")
#warning("TODO: [Priority: high] configurable for .top or .bottom style.")
struct VDrawer<Foreground, Background, Handle>: View
where Foreground: View, Background: View, Handle: View {
  private let minTopPadding: CGFloat = 150.0

  @State
  private var topPadding: CGFloat = 450.0

  private var topTransparent: some View {
    Rectangle()
      .fill(Color.clear)
  }

  private let background: Background
  private let foreground: Foreground
  private let handle: Handle

  private var foregroundContainer: some View {
    VStack(spacing: 0.0) {
      topTransparent
        .frame(height: topPadding)

      VStack(spacing: 0.0) {
        handle
          .gesture(
            DragGesture()
              .onChanged(adjustTopPadding)
          )

        foreground
      }
    }
  }

  var body: some View {
    ZStack {
      background
      foregroundContainer
    }
  }

  init(
    @ViewBuilder background: () -> Background,
    @ViewBuilder foreground: () -> Foreground,
    @ViewBuilder handle: () -> Handle
  ) {
    self.background = background()
    self.foreground = foreground()
    self.handle = handle()
  }
}

extension VDrawer {
  private func adjustTopPadding(_ value: DragGesture.Value) {
    let newTopPadding = topPadding + value.translation.height

    topPadding = max(minTopPadding, newTopPadding)
  }
}

// MARK: - Previews

struct VDrawer_Previews: PreviewProvider {
  static var previews: some View {
    VDrawer(
      background: {
        Rectangle()
          .fill(Color.yellow)
      },
      foreground: {
        Rectangle()
          .fill(Color.red)
      },
      handle: {
        Rectangle()
          .fill(Color.green)
          .frame(height: 44.00)
      }
    )
  }
}
