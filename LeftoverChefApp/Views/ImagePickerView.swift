import SwiftUI

struct ImagePickerView: UIViewControllerRepresentable {
    @ObservedObject var viewModel: ImagePickerViewModel
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(viewModel: viewModel)
    }
    
    func makeUIViewController(context: Context) -> UIImagePickerController {
        let imagePickerController = UIImagePickerController()
        imagePickerController.sourceType = .camera
        imagePickerController.delegate = context.coordinator
        return imagePickerController
    }
    
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {
        // 処理なし
    }
    
    class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
        var viewModel: ImagePickerViewModel
        
        init(viewModel: ImagePickerViewModel) {
            self.viewModel = viewModel
        }
        
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            viewModel.imagePickerController(picker, didFinishPickingMediaWithInfo: info)
        }
        
        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            viewModel.imagePickerControllerDidCancel(picker)
        }
    }
}
