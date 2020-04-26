//
//  Stateful.swift
//  
//
//  Created by Roy Hsu on 2020/4/25.
//

import SwiftUI

struct Stateful<Value, Content>: View where Content: View {
  @State
  private var value: Value
  private var content: (Binding<Value>) -> Content
  var body: some View {
    content($value)
  }
  
  init(
    _ value: Value,
    content: @escaping (Binding<Value>) -> Content
  ) {
    self._value = State(wrappedValue: value)
    self.content = content
  }
}
