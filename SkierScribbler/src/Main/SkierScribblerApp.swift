//
//  SkierScribblerApp.swift
//  SkierScribbler
//
//  Created by Owen Cruz-Abrams on 9/18/23.
//

import SwiftUI
import FontBlaster

@main
struct SkierScribblerApp: App {
    init() {
        #if DEBUG
        FontBlaster.debugEnabled = true
        #endif
        FontBlaster.blast()
        UINavigationBar.appearance().titleTextAttributes = [.font: UIFont(name: "UpperWestSide", size: 25)!]

    }
    var body: some Scene {
        WindowGroup {
            MotherView()
        }
    }
}
