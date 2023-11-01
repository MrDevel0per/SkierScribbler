//
//  PlatformCompatibility.swift
//  SkierScribbler
//
//  Created by Owen Cruz-Abrams on 10/31/23.
//

import Foundation

// We create the UX-ETC types below, replacing UI- and NS-
#if canImport(UIKit)
import UIKit
typealias UXFont = UIFont
#elseif canImport(AppKit)
import AppKit
typealias UXFont = NSFont
#endif
