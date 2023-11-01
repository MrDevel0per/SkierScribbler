//
//  GeoFrame.swift
//  SkierScribbler
//
//  Created by Owen Cruz-Abrams on 10/31/23.
//

import Foundation
import SwiftUI

/// A ``SwiftUI.Frame`` object, but with awareness of the width and height of the window or screen.
/// - Note: The `ScreenAwareFrame` uses a `UIScreen` instance found through context
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
    func awareFrame(width widthPercentage: CGFloat, height heightPercentage: CGFloat, alignment: Alignment = .center) -> some View {
        modifier(ScreenAwareFrame(heightPercentage: heightPercentage, widthPercentage: widthPercentage, alignment: alignment))
    }
}

#Preview {
    //FIXME: The `ScrollView` causes the images to be rendered at a TINY size - an issue with GeometryReader?
    ScrollView{
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
