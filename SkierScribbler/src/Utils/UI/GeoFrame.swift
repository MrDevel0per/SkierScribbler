//
//  GeoFrame.swift
//  SkierScribbler
//
//  Created by Owen Cruz-Abrams on 10/31/23.
//

import Foundation
import SwiftUI

/// A ``SwiftUI.Frame`` object, but with awareness of the width and height of the window or screen.
struct ScreenAwareFrame: ViewModifier {
    var heightPercentage: CGFloat
    var widthPercentage: CGFloat
    var alignment: Alignment = .center
    func body(content: Content) -> some View {
        GeometryReader { geo in
            content
                .frame(width: widthPercentage * geo.size.width, height: heightPercentage * geo.size.height, alignment: alignment)
        }
    }
}

extension View {
    func awareFrame(width widthPercentage: CGFloat, height heightPercentage: CGFloat, alignment: Alignment = .center) -> some View {
        modifier(ScreenAwareFrame(heightPercentage: heightPercentage, widthPercentage: widthPercentage, alignment: alignment))
    }
}

#Preview {
    Text("Hello, world! I should be centered.")
        .modifier(ScreenAwareFrame(heightPercentage: 1, widthPercentage: 1))
}
