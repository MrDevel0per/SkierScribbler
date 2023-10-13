//
//  LogoView.swift
//  SkierScribbler
//
//  Created by Owen Cruz-Abrams on 10/12/23.
//

import SwiftUI

struct LogoView: View {
    var includeThe: Bool = true
    var body: some View {
        Text("\(includeThe ? "The " : "")Skier Scribbler")
            .font(.largeTitle(.upperWestSide))
    }
}

#Preview {
    LogoView()
}
