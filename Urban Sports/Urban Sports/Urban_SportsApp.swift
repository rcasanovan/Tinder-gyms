//
//  Urban_SportsApp.swift
//  Urban Sports
//
//  Created by Ricardo Casanova Nébola on 22/4/24.
//

import ComposableArchitecture
import SwiftUI

@main
struct Urban_SportsApp: App {
  var body: some Scene {
    WindowGroup {
      LoadActivitesView(
        store: .init(
          initialState: .init(networkState: .ready),
          reducer: {
            LoadActivites()
          }
        )
      )
    }
  }
}
