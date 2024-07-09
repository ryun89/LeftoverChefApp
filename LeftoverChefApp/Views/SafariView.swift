import SwiftUI
import SafariServices

// SFSafariViewControllerを起動する構造体
struct SafariView: UIViewControllerRepresentable {
    // 表示するURLを受け取る変数
    let url: URL
    
    // 表示するViewを生成する際に呼び出す
    func makeUIViewController(context: Context) -> some UIViewController {
        // Safariを起動
        return SFSafariViewController(url: url)
    }
    
    // Viewを更新する際に呼び出される
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
        // 処理なし
    }
}
