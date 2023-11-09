//
//  ArticleView.swift
//  SkierScribbler
//
//  Created by Owen Cruz-Abrams on 11/3/23.
//

import SwiftUI

struct ArticleView: View {
    var article: Article
    @State var webPageURL: URL
    @State var percentLoaded: Double
    @State var isDoneLoading: Bool

    init(article: Article, percentLoaded: Double = 0, isDoneLoading: Bool = false) {
    @State var isSheetOpen: Bool = true
=======
    @State var isSheetOpen: Bool = true
        self.article = article
        _webPageURL = State(initialValue: article.url)
        _percentLoaded = State(initialValue: percentLoaded)
        _isDoneLoading = State(initialValue: isDoneLoading)
    }

    var body: some View {
        if webPageURL.isArticleURL {
            WebViewBridge(
                url: $webPageURL,
                percentLoaded: $percentLoaded,
                isDoneLoading: $isDoneLoading,
                javaScriptOnLoad: removeHeaders()
            )
        } else {
            Sheet(isPresented: .constant(true)) {
                WebViewBridge(url: .constant(webPageURL), percentLoaded: $percentLoaded, isDoneLoading: $isDoneLoading)
            }
        }
//            loadingView()
//        }
    }
}

#Preview {
    ArticleView(article: .sampleArticle)
}

extension ArticleView {
    /// Generate the `JavaScript` needed to remove all headers **and footers**.
    /// - seealso: https://stackoverflow.com/a/14066534/
    func removeHeaders() -> String {
        """
function removeElementsByClass(className){
    const elements = document.getElementsByClassName(className);
    while(elements.length > 0){
        elements[0].parentNode.removeChild(elements[0]);
    }
}
removeElementsByClass("sno-header-wrap");
removeElementsByClass("footer");
"""
    }

    @ViewBuilder func loadingView() -> some View {
        // TODO: Fancify
        ProgressView(value: percentLoaded)
    }
}
