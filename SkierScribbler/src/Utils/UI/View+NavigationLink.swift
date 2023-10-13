//
//  View+NavigationLink.swift
//  SkierScribbler
//
//  Created by Owen Cruz-Abrams on 10/12/23.
//

import Foundation
import SwiftUI

extension View {
    func navigationLink(destination: @escaping() -> some View) -> some View {
        NavigationLink {
            destination()
        } label: {
            self
        }

    }
}
