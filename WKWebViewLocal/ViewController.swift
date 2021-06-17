//
//  ViewController.swift
//  WKWebViewLocal
//

import UIKit
import WebKit

class ViewController: UIViewController {
    @IBOutlet weak var webView: WebView!
    var strName: String?
    override func viewDidLoad() {
        super.viewDidLoad()
        self.webView.backgroundColor = .green
        webView.contentMode = .scaleAspectFit
        title = "WKWebView"
        webView.navigationDelegate = self

        // Add addScriptMessageHandler in javascript: window.webkit.messageHandlers.MyObserver.postMessage()
        webView.configuration.userContentController.add(self, name: "MyObserver")

        // inject JS to capture console.log output and send to iOS
        let source = "function captureLog(msg) { window.webkit.messageHandlers.logHandler.postMessage(msg); } window.console.log = captureLog;"
        let script = WKUserScript(source: source, injectionTime: .atDocumentEnd, forMainFrameOnly: false)
        webView.configuration.userContentController.addUserScript(script)
        // register the bridge script that listens for the output
        webView.configuration.userContentController.add(self, name: "logHandler")

        // Choose to load a file or a string
        let loadFile = false

        if let filePath = Bundle.main.path(forResource: "index", ofType: "html", inDirectory: "Web_Assets") {
            if loadFile {
                // load file
                let filePathURL = URL.init(fileURLWithPath: filePath)
                let fileDirectoryURL = filePathURL.deletingLastPathComponent()
                webView.loadFileURL(filePathURL, allowingReadAccessTo: fileDirectoryURL)
            } else {
                do {
                    // load html string - baseURL needs to be set for local files to load correctly
                    let html = try String(contentsOfFile: filePath, encoding: .utf8)
                    webView.loadHTMLString(html, baseURL: Bundle.main.resourceURL?.appendingPathComponent("Web_Assets"))
                } catch {
                    print("Error loading html")
                }
            }
        }
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.callJavascriptTapped()
    }

    private func documentDirectory() -> String {
        let documentDirectory = NSSearchPathForDirectoriesInDomains(.documentDirectory,
                                                                    .userDomainMask,
                                                                    true)
        return documentDirectory[0]
    }

    private func append(toPath path: String,
                        withPathComponent pathComponent: String) -> String? {
        if var pathURL = URL(string: path) {
            pathURL.appendPathComponent(pathComponent)

            return pathURL.absoluteString
        }

        return nil
    }

    private func read(fromDocumentsWithFileName fileName: String) {
        guard let filePath = self.append(toPath: self.documentDirectory(), withPathComponent: fileName) else { return }

        do {
            let savedString = try String(contentsOfFile: filePath)

            print(savedString)
        } catch {
            print("Error reading saved file")
        }
    }

    private func save(text: String, toDirectory directory: String, withFileName fileName: String) {
        guard let filePath = self.append(toPath: directory, withPathComponent: fileName) else {return }

        do {
            try text.write(toFile: filePath, atomically: true, encoding: .utf8)
        } catch {
            print("Error save", error)
            return
        }

        print("Save successful")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

   private func callJavascriptTapped() {
        let script = "getPdf()"
        webView.evaluateJavaScript(script) { (result: Any?, error: Error?) in
            if let error = error {
                print("evaluateJavaScript error: \(error.localizedDescription)")
            } else {
                print("evaluateJavaScript result: \(result ?? "")")
                print("evaluateJavaScript ok = ")

                if let resultString = result as? String {
                    self.save(text: resultString,
                              toDirectory: self.documentDirectory(),
                              withFileName: "result.pdf")
                }

            }
        }

    }
}

extension ViewController: WKScriptMessageHandler {
    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        switch message.name {
        case "MyObserver":
            // Callback from javascript: window.webkit.messageHandlers.MyObserver.postMessage(message)
            let text = message.body as! String
            let alertController = UIAlertController(title: "Javascript said:", message: text, preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default) { (_) in
                print("OK")
            }
            alertController.addAction(okAction)
            present(alertController, animated: true, completion: nil)
        case "logHandler":
            print("LOG: \(message.body)")
            let src = "<embed type=\"application/pdf\" src=\"\((message.body))\"/>"
            webView.loadHTMLString(src, baseURL: nil)
            print("finished")
        default:
            print("default")
        }

    }
}

extension ViewController: WKNavigationDelegate {
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        print("didFinish navigation:")
    }
}
