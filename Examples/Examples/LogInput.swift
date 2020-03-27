//
//  LogInput.swift
//  
//
//  Created by Roy Hsu on 2020/3/27.
//

import SwiftUI

struct LogInput: View {
  @State
  private var input = ""
  var log: (_ message: String) -> Void
  
  var body: some View {
    Form {
      Section {
        TextField("Input", text: $input)
      }
      Section {
        HStack {
          Spacer()
          Button(action: sendLog) {
            Text("Log")
          }
          Spacer()
        }
      }
    }
  }
  
  private func sendLog() {
    log(input)
    input = ""
  }
}

// MARK: - Previews

struct LogInput_Previews: PreviewProvider {
  static var previews: some View {
    LogInput(log: { _ in })
  }
}
