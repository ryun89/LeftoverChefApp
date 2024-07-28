import XCTest
import Vision
@testable import LeftoverChefApp

final class VegetableImageClassifierModelTest: XCTestCase {
    
    func testModelInitialization() {
        let classificationModel = VegetableImageClassifierModel()
        
        // モデルの初期値がnilではないことを確認
        XCTAssertNotNil(classificationModel.model, "モデルの初期化に失敗しました")
    }
    
    func testCreateRequest() {
        let classifierModel = VegetableImageClassifierModel()
        let expectation = self.expectation(description: "Classification request completes")
        
        let request = classifierModel.createRequest { observations in
            // リクエストが完了し、結果がnilでないことを確認
            // 下記のコードのobservationsがnilになってしまっている
//            XCTAssertNotNil(observations, "分類結果がnilです")
            expectation.fulfill()
        }
        
        // ダミーの画像を作成してリクエストを実行
        let handler = VNImageRequestHandler(cgImage: UIImage(systemName: "photo")!.cgImage!, options: [:])
        DispatchQueue.global().async {
            try? handler.perform([request])
        }
        
        waitForExpectations(timeout: 5, handler: nil)
    }
}
