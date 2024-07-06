import SwiftUI

class ImageModel: ObservableObject {
    // 撮影された写真を保持する変数
    @Published var capturedImage: UIImage?
    
    // sheetを表示するかのフラグ
    @Published var isShowingSheet: Bool = false
}

