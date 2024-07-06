import SwiftUI

class ImagePickerViewModel: NSObject, ObservableObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    @Published var model: ImageModel
    
    init(model: ImageModel) {
        self.model = model
    }
    
    // 写真が撮影された時に実行
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let originalImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            model.capturedImage = originalImage
        }
        model.isShowingSheet.toggle()
    }
    
    // 撮影がキャンセルされた時に実行
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        model.isShowingSheet.toggle()
    }
}
