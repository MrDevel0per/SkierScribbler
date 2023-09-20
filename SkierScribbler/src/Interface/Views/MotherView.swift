//
//  MotherView.swift
//  SkierScribbler
//
//  Created by Owen Cruz-Abrams on 9/18/23.
//

import SwiftUI

/// The ``MotherView`` contains the overall heirarchy of the app.
///
/// It contains the ``TabView`` which has the four tabs of the app: Home, Print Editions, Search, and SkierTV.
struct MotherView: View {
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
        }
        .padding()
    }
}

#Preview {
    MotherView()
}
