//
//  WebViewBridge.swift
//  SkierScribbler
//
//  Created by Owen Cruz-Abrams on 11/3/23.
//

import Foundation
import UIKit
import SwiftUI
import WebKit
import WebFilter

struct WebViewBridge: UIViewRepresentable {

    typealias UIViewType = WKWebView

    // We abstract all logic to the super-SwiftUI-views for this, this is a lower-level method
    @Binding var url: URL

    @Binding var percentLoaded: Double

    @Binding var isDoneLoading: Bool

    @State var pageContents: String = ""

    /// The `JavaScript` for the ``WebViewBridge``'s ``Coordinator`` to evaluate when the WebView finishes loading.
    /// - Note: It is not possible to
    var javaScriptOnLoad: String = ""

    func makeUIView(context: Context) -> WKWebView {
        let webView = WKWebView()

        // Don't let the user go back and forward - we want the sense that this is a native, non-web-view view
        webView.allowsBackForwardNavigationGestures = true

        // Our `Coordinator` handles all of the loading and things that need to be passed back and forth
        webView.navigationDelegate = context.coordinator

        // Allow the user to find text in the article
        webView.isFindInteractionEnabled = true

        // ???: Should we change this?
        webView.allowsLinkPreview = false

        return webView

    }

    func updateUIView(_ uiView: WKWebView, context: Context) {
        let request = URLRequest(url: url)
        
        if url.isArticleURL {
            uiView.load(request)
        } else {
            Sheet(isPresented: .constant(true)) {
                WebViewBridge(url: .constant(url), percentLoaded: $percentLoaded, isDoneLoading: $isDoneLoading)
            }
        }
    }

    func makeCoordinator() -> Coordinator {
        return Coordinator(self)
    }

}

extension WebViewBridge {
    class Coordinator: NSObject, WKNavigationDelegate {
        var parent: WebViewBridge

        init(_ parent: WebViewBridge) {
            self.parent = parent
        }

        func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction) async -> WKNavigationActionPolicy {
            if let host = navigationAction.request.url {
                // TODO: Impliment pageContents
                let shouldContinue = WebFilter.filterURL(url: host, pageContents: "")
                return shouldContinue ? WKNavigationActionPolicy.allow : WKNavigationActionPolicy.cancel
            }

            return WKNavigationActionPolicy.cancel

        }

        func getContents(_ webView: WKWebView) throws {
            var myError: Error?
            webView.evaluateJavaScript("document.documentElement.outerHTML") { response, error in
                if let contents = response as? String {
                    self.parent.pageContents = contents
                }
                self.parent.pageContents = ""
                myError = error
            }
            if let myError {
                throw myError
            }
        }

        func webView(_ webView: WKWebView, didCommit navigation: WKNavigation!) {
            parent.isDoneLoading = false
            parent.percentLoaded = webView.estimatedProgress
        }

        func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
            parent.percentLoaded = webView.estimatedProgress
        }

        func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
            try? getContents(webView)

            if parent.javaScriptOnLoad != "" {
                webView.evaluateJavaScript(parent.javaScriptOnLoad)
            }
            // IMPORTANT: THIS MUST BE SET AFTER JS EVALUATION, OTHERWISE WE MIGHT NOT SHOW WHAT WE WANT!
            parent.isDoneLoading = true
        }

    }

}
