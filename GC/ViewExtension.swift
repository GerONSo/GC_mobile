//
//  ViewExtension.swift
//  GC
//
//  Created by Sergey Goncharov on 19.12.2023.
//

import SwiftUI
import Foundation

extension View {
  @ViewBuilder func visibility(_ visibility: ViewVisibility) -> some View {
    if visibility != .gone {
      if visibility == .visible {
        self
      } else {
        hidden()
      }
    }
  }
}


enum ViewVisibility: CaseIterable {
    case visible, invisible, gone
}
