import SwiftUI

struct ImagePickerView: UIViewControllerRepresentable {
    // UIImagePickerControllerで撮影された画像が表示されているかを管理
    @Binding var isShowingSheet: Bool

    // 撮影された画像を保持する変数
    @Binding var capturedImage: UIImage?
    
    // Coordinatorでコントローラのdelegeteを管理
    class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
        // ImagePicker型の変数を用意
        let parent: ImagePickerView
        
        // イニシャライザ
        init(_ parent: ImagePickerView) {
            self.parent = parent
        }
        
        // 撮影が終了したら呼び出されるdelegeteメソッド
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            // 撮影した画像をcapturedimageに保存する
            if let originalImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
                parent.capturedImage = originalImage
            }
            
            // sheetを閉じる
            parent.isShowingSheet.toggle()
        }
        
        //　キャンセルボタンが押された時に呼ばれるdelegeteメソッド
        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            // sheetを閉じる
            parent.isShowingSheet.toggle()
        }
    }
}
