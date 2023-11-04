//
//  GeoFrame.swift
//  SkierScribbler
//
//  Created by Owen Cruz-Abrams on 10/31/23.
//

import Foundation
import SwiftUI

//FIXME: Does this actually work, or do we just end up with the default max of 500?
/// A ``SwiftUI.Frame`` object, but with awareness of the width and height of the window or screen.
/// - Note: The `ScreenAwareFrame` uses a `UIScreen` instance found through context rather than the deprciated `UIScreen.main`.
struct ScreenAwareFrame: ViewModifier {
    var heightPercentage: CGFloat
    var widthPercentage: CGFloat
    var alignment: Alignment = .center
    func body(content: Content) -> some View {
            content
            .frame(width: widthPercentage * (UIScreen.current?.bounds.size.width ?? 500), height: heightPercentage * (UIScreen.current?.bounds.size.height ?? 500), alignment: alignment)
            .onAppear(perform: {
                print(UIScreen.current?.bounds.size != nil, "It was nil!")
            })
    }
}

extension View {
    func awareFrame(
        width widthPercentage: CGFloat,
        height heightPercentage: CGFloat,
        alignment: Alignment = .center
    ) -> some View {
        modifier(ScreenAwareFrame(heightPercentage: heightPercentage, widthPercentage: widthPercentage, alignment: alignment))
    }
}

#Preview {
    ScrollView {
        VStack {
            ArticleListItem(article: .sampleArticle)
            ArticleListItem(article: .sampleArticle)
            //        AsyncImage(url: Article.sampleArticle.imageURL) { img in
            //            img
            //                .resizable()
            //                .scaledToFit()
            //        } placeholder: {
            //            ProgressView()
            //        }
            //
            //        .modifier(ScreenAwareFrame(heightPercentage: 0.5, widthPercentage: 1))
            //        AsyncImage(url: Article.sampleArticle.imageURL) { img in
            //        img
            //            .resizable()
            //            .scaledToFit()
            //    } placeholder: {
            //        ProgressView()
            //    }
            //
            //    .modifier(ScreenAwareFrame(heightPercentage: 0.5, widthPercentage: 1))
            //        Spacer()
        }
    }
}
