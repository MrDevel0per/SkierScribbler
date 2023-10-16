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
    @State var articles: [Article] = []
    var body: some View {
            
           ArticleListView()
    }
}

#Preview {
    MotherView()
}
