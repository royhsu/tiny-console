//
//  Example.swift
//  Examples
//
//  Created by Roy Hsu on 2020/3/27.
//  Copyright © 2020 TinyWorld. All rights reserved.
//

import SwiftUI

struct Example: View {
  var id = UUID()
  var title: String
  var body: AnyView
}

// MARK: - Identifiable

extension Example: Identifiable {}
