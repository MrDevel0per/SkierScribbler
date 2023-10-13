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
    @State var urls: [URL] = []
    var body: some View {
        List(urls, id: \.self) {url in
            Text(url.relativeString).textSelection(.enabled)
        }
//        .task {
//            do {
//                let doc = try await APIClient.shared.fetchPage(at: URL(string: "https://skierscribbler.com/category/news/")!)
//                urls = try Parser.shared._parseCategoryURLs(doc)
//            } catch {
//                print("An error occured when getting the stuff: \(error.localizedDescription)")
//            }
//            
//        }
        .padding()
    }
}

#Preview {
    MotherView()
}
