import SwiftUI
import CoreML
import Vision

class ImagePickerViewModel: NSObject, ObservableObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    @Published var model: ImageModel
    private var vegetableImageClassifierModel = VegetableImageClassifierModel()
    
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
    
    // 撮影した画像が何の野菜かを分類する
    func classifyImage(image: UIImage) {
        guard let ciImage = CIImage(image: image) else {
            return
        }
        
        // 画像の分類を行う
        let request = VNCoreMLRequest(model: vegetableImageClassifierModel.model) { [weak self] (request, error) in
            guard let results = request.results as? [VNClassificationObservation],
            let topResult = results.first else{
                return
            }
            
            // 分類されたラベル名を変数に格納
            DispatchQueue.main.sync {
                self?.model.classificationLabel = topResult.identifier
            }
        }
        
        let handler = VNImageRequestHandler(ciImage: ciImage, options: [:])
        try? handler.perform([request])
    }
}
