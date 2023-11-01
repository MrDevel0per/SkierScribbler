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
        //???: We cannot set the background and the font. Instead, we use a default background. FIXME?
        UINavigationBar.appearance().titleTextAttributes = [.font: UIFont(name: "UpperWestSide", size: 25) ?? UIFont.systemFont(ofSize: 25)]
        UINavigationBar.appearance().largeTitleTextAttributes = [.font: UIFont(name: "UpperWestSide", size: 40) ?? UIFont.systemFont(ofSize: 40)]
        #if DEBUG
        print("Application Directory:", NSHomeDirectory())
        #endif

    }
    var body: some Scene {
        WindowGroup {
            NavigationStack {
                MotherView()
            }
        }
    }
}
