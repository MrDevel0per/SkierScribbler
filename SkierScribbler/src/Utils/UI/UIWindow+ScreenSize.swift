//
//  UIWindow+ScreenSize.swift
//  SkierScribbler
//
//  Created by Owen Cruz-Abrams on 11/1/23.
// Attribution: Code taken from
// https://stackoverflow.com/questions/74458971/

import Foundation
import UIKit

extension UIWindow {
    static var current: UIWindow? {
        for scene in UIApplication.shared.connectedScenes {
            guard let windowScene = scene as? UIWindowScene else { continue }
            if let keyWindow = windowScene.windows.first(where: {$0.isKeyWindow}) {
                return keyWindow
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
