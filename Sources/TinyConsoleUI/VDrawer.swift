//
//  VDrawer.swift
//  
//
//  Created by Roy Hsu on 2020/3/27.
//

import SwiftUI

#warning("TODO: [Priority: high] should set a maximum value for the top padding.")
#warning("TODO: [Priority: high] configurable for .top or .bottom style.")
struct VDrawer<Foreground, Background>: View
where Foreground: View, Background: View {
  private let minTopPadding: CGFloat = 50.0
  private let defaultTopPadding: CGFloat = 450.0
  @State
  private var topPadding: CGFloat
  private var topTransparent: some View {
    Rectangle()
      .fill(Color.clear)
  }
  @ObservedObject
  var drag: DragStore
  private let background: Background
  private let foreground: Foreground
  private var foregroundContainer: some View {
    VStack(spacing: 0.0) {
      topTransparent
        .frame(height: topPadding)
      foreground
    }
  }
  var body: some View {
    ZStack {
      background
      foregroundContainer
    }
      .onReceive(drag.$translation) { _ in
        self.updateTopPadding()
      }
  }

  init(
    drag: DragStore,
    @ViewBuilder background: () -> Background,
    @ViewBuilder foreground: () -> Foreground
  ) {
    self.drag = drag
    self._topPadding = State(
      wrappedValue: max(
        minTopPadding,
        defaultTopPadding + drag.translation.height
      )
    )
    self.background = background()
    self.foreground = foreground()
  }
}

extension VDrawer {
  private func updateTopPadding() {
    let newTopPadding = topPadding + drag.translation.height
    topPadding = max(minTopPadding, newTopPadding)
  }
}

/// Since didSet/willSet don't work under currrent Swift 5.2, we need to use this as workaround.
/// Deprecate this once the bug gets fixed.
final class DragStore: ObservableObject {
  @Published
  var translation: CGSize = .zero
}

// MARK: - Previews

struct VDrawer_Previews: PreviewProvider {
  static var previews: some View {
    let drag = DragStore()
    
    return VDrawer(
      drag: drag,
      background: {
        Rectangle()
          .fill(Color.yellow)
      },
      foreground: {
        Text("Δx: \(drag.translation.width)\nΔy: \(drag.translation.height)")
          .frame(maxWidth: .infinity, maxHeight: .infinity)
          .background(Color.red)
          .gesture(
            DragGesture()
              .onChanged { change in
                drag.translation = change.translation
              }
          )
      }
    )
  }
}
