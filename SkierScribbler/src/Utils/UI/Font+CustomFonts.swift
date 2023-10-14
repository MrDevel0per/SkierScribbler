//
//  Font+CustomFonts.swift
//  SkierScribbler
//
//  Created by Owen Cruz-Abrams on 10/9/23.
//

import Foundation
import SwiftUI

extension Font {
    /// A font with the large title text style.
    /// - Parameter font: The custom font to use.
    /// - Returns: A font with the large title text style.
    static func body(_ font: CustomFont) -> Self {
        return Font.custom(font.rawValue, size: UIFont.preferredFont(forTextStyle: .body).pointSize)
    }
    
    /// A font with the callout text style.
    /// - Parameter font: The custom font to use.
    /// - Returns: A font with the callout text style.
    static func callout(_ font: CustomFont) -> Self {
        return Font.custom(font.rawValue, size: UIFont.preferredFont(forTextStyle: .callout).pointSize)
    }

    static func caption(_ font: CustomFont) -> Self {
        return Font.custom(font.rawValue, size: UIFont.preferredFont(forTextStyle: .caption1).pointSize)
    }

    static func caption2(_ font: CustomFont) -> Self {
        return Font.custom(font.rawValue, size: UIFont.preferredFont(forTextStyle: .caption2).pointSize)
    }

    static func footnote(_ font: CustomFont) -> Self {
        return Font.custom(font.rawValue, size: UIFont.preferredFont(forTextStyle: .footnote).pointSize)
    }

    static func headline(_ font: CustomFont) -> Self {
        return Font.custom(font.rawValue, size: UIFont.preferredFont(forTextStyle: .headline).pointSize)
    }

    static func largeTitle(_ font: CustomFont) -> Self {
        return Font.custom(font.rawValue, size: UIFont.preferredFont(forTextStyle: .largeTitle).pointSize)
    }

    static func subheadline(_ font: CustomFont) -> Self {
        return Font.custom(font.rawValue, size: UIFont.preferredFont(forTextStyle: .subheadline).pointSize)
    }

    static func title(_ font: CustomFont) -> Self {
        return Font.custom(font.rawValue, size: UIFont.preferredFont(forTextStyle: .title1).pointSize)
    }

    static func title2(_ font: CustomFont) -> Self {
        return Font.custom(font.rawValue, size: UIFont.preferredFont(forTextStyle: .title2).pointSize)
    }

    static func title3(_ font: CustomFont) -> Self {
        return Font.custom(font.rawValue, size: UIFont.preferredFont(forTextStyle: .title3).pointSize)
    }

    static func extraLargeTitle(_ font: CustomFont) -> Self {
        return Font.custom(font.rawValue, size: UIFont.preferredFont(forTextStyle: .extraLargeTitle).pointSize)
    }

    static func extraLargeTitle2(_ font: CustomFont) -> Self {
        return Font.custom(font.rawValue, size: UIFont.preferredFont(forTextStyle: .extraLargeTitle2).pointSize)
    }

    

    
    
}

extension Font.TextStyle {
    func UIME() -> UIFont.TextStyle {
        switch self {
        case .largeTitle:
            return .largeTitle
        case .title:
            return .title1
        case .title2:
            return .title2
        case .title3:
            return .title3
        case .headline:
            return .headline
        case .subheadline:
            return .subheadline
        case .body:
            return .body
        case .callout:
            return .callout
        case .footnote:
            return .footnote
        case .caption:
            return .caption1
        case .caption2:
            return .caption2
        case .extraLargeTitle:
            return .extraLargeTitle
        case .extraLargeTitle2:
            return .extraLargeTitle2
        @unknown default:
            return .body
        }
    }
}

enum CustomFont: String {
    case alegreya = "Alegreya"
    case rokkitt = "Rokkitt"
    case upperWestSide = "UpperWestSide"
}
