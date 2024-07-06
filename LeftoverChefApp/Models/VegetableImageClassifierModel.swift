import Foundation
import CoreML
import Vision

class VegetableImageClassifierModel {
    let model: VNCoreMLModel
    
    init() {
        let config = MLModelConfiguration()
        let coreMLModel = try! VegetableImageClassifier(configuration: config)
        self.model = try! VNCoreMLModel(for: coreMLModel.model)
    }
    
    // 画像データを分類するリクエストを作成する
    func createRequest(completion: @escaping ([VNClassificationObservation]?) -> Void) -> VNCoreMLRequest {
        return VNCoreMLRequest(model: model) { request, error in
            completion(request.results as? [VNClassificationObservation])
        }
    }
}
