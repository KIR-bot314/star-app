import SwiftUI
import WebKit
import Network

/// Адрес веб-приложения. Вся логика живёт там (GitHub Pages),
/// эта обёртка только показывает его как обычное приложение iOS.
let appURL = URL(string: "https://kir-bot314.github.io/star-app/")!
let skyUIColor = UIColor(red: 13 / 255, green: 15 / 255, blue: 43 / 255, alpha: 1) // #0d0f2b

struct ContentView: View {
    @StateObject private var model = WebModel()

    var body: some View {
        ZStack {
            Color(skyUIColor).ignoresSafeArea()
            WebView(model: model).ignoresSafeArea()
            if model.failed {
                VStack(spacing: 16) {
                    Text("⭐").font(.system(size: 64))
                    Text("Нет связи").font(.title2.bold())
                    Button("Попробовать снова") { model.reload() }
                        .buttonStyle(.borderedProminent)
                }
                .foregroundStyle(.white)
                .padding()
            }
        }
        .preferredColorScheme(.dark)
    }
}

final class WebModel: NSObject, ObservableObject, WKNavigationDelegate {
    @Published var failed = false
    let webView: WKWebView
    private let monitor = NWPathMonitor()

    override init() {
        let config = WKWebViewConfiguration()
        config.allowsInlineMediaPlayback = true
        config.mediaTypesRequiringUserActionForPlayback = []
        config.websiteDataStore = .default()
        webView = WKWebView(frame: .zero, configuration: config)
        super.init()
        webView.navigationDelegate = self
        webView.isOpaque = false
        webView.backgroundColor = skyUIColor
        webView.scrollView.backgroundColor = skyUIColor
        webView.scrollView.bounces = false
        webView.scrollView.contentInsetAdjustmentBehavior = .never
        webView.allowsBackForwardNavigationGestures = false
        webView.allowsLinkPreview = false
        reload()

        // Появилась сеть, а страница так и не загрузилась — пробуем сами, без тапа ребёнка.
        monitor.pathUpdateHandler = { [weak self] path in
            guard path.status == .satisfied else { return }
            DispatchQueue.main.async {
                if let self, self.failed { self.reload() }
            }
        }
        monitor.start(queue: DispatchQueue(label: "net"))
    }

    func reload() {
        failed = false
        webView.load(URLRequest(url: appURL))
    }

    // Страница не загрузилась (нет сети при запуске) — показываем кнопку «Попробовать снова».
    func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
        if (error as NSError).code == NSURLErrorCancelled { return }
        NSLog("Звёздочки: страница не загрузилась: %@", error.localizedDescription)
        failed = true
    }

    // Система выгрузила веб-процесс в фоне — при возврате просто перезагружаем.
    func webViewWebContentProcessDidTerminate(_ webView: WKWebView) {
        reload()
    }
}

struct WebView: UIViewRepresentable {
    let model: WebModel
    func makeUIView(context: Context) -> WKWebView { model.webView }
    func updateUIView(_ uiView: WKWebView, context: Context) {}
}
