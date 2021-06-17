//
//  WebView.swift
//  WKWebViewLocal
//

import WebKit

// Wrap the WKWebView webview to allow IB use

class WebView: WKWebView {
    required init?(coder: NSCoder) {
        let configuration = WKWebViewConfiguration()
        let controller = WKUserContentController()
        configuration.userContentController = controller
        super.init(frame: CGRect.zero, configuration: configuration)
    }
}
