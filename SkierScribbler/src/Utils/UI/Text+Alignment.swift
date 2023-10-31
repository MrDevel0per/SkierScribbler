//
//  Text+Alignment.swift
//  SkierScribbler
//
//  Created by Owen Cruz-Abrams on 10/30/23.
//

import Foundation
import SwiftUI

extension View {
    func leftAlign() -> some View {
        HStack {
            self
                .multilineTextAlignment(.leading)
            Spacer()
        }
    }
}
