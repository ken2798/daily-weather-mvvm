

import MBProgressHUD

class WebViewController: UIViewController {

    @IBOutlet private weak var loadingView: UIView!
    @IBOutlet private weak var webView: UIWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let url = URL(string: "https://686online.site/weather")!
        let request = URLRequest(url: url)
        webView.loadRequest(request)
        configView()
    }
    
    private func configView() {
        webView.delegate = self
        loadingView.isHidden = false
        let hud = MBProgressHUD.showAdded(to: loadingView, animated: true)
        hud.offset.y = -30
    }

    @IBAction func handleTapBackButton(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
}
extension WebViewController: StoryboardSceneBased {
    static var sceneStoryboard = Storyboards.webView
}

extension WebViewController: UIWebViewDelegate {
    func webViewDidFinishLoad(_ webView: UIWebView) {
        MBProgressHUD.hide(for: self.view, animated: true)
        loadingView.isHidden = true
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        scrollView.backgroundColor = #colorLiteral(red: 0.9688121676, green: 0.9688346982, blue: 0.9688225389, alpha: 1)
    }
}
