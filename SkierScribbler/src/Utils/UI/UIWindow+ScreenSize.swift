//
//  UIWindow+ScreenSize.swift
//  SkierScribbler
//
//  Created by Owen Cruz-Abrams on 11/1/23.
// Attribution: Code taken from https://stackoverflow.com/questions/74458971/correct-way-to-get-the-screen-size-on-ios-after-uiscreen-main-deprecation

import Foundation
import UIKit

extension UIWindow {
    static var current: UIWindow? {
        for scene in UIApplication.shared.connectedScenes {
            guard let windowScene = scene as? UIWindowScene else { continue }
            for window in windowScene.windows {
                if window.isKeyWindow { return window }
            }
        }
        return nil
    }
}


extension UIScreen {
    static var current: UIScreen? {
        UIWindow.current?.screen
    }
}
