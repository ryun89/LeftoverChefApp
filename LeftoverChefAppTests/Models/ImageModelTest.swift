import XCTest
import SwiftUI
@testable import LeftoverChefApp

class ImageModelTest: XCTestCase {
    
    func testInitialValues() {
        let model = ImageModel()
        
        // 初期化時に全てのプロパティが期待通りの値を持っているかを確認
        XCTAssertNil(model.capturedImage, "初期化時にcapturedImageはnilであるべき")
        XCTAssertNil(model.classificationLabel, "初期化時にclassificationLabelはnilであるべき")
        XCTAssertFalse(model.isShowingSheet, "初期化時にisShowingSheetはfalseであるべき")
    }
    
    func testCaptureImageUpdate() {
        let model = ImageModel()
        let testImage = UIImage(systemName: "photo")
        
        model.capturedImage = testImage
        
        XCTAssertEqual(model.capturedImage, testImage, "capturedImageは設定された値と同じであるべき")
    }
    
    func testClassificationLabelUpdate() {
        let model = ImageModel()
        let testLabel = "Test Label"
        
        model.classificationLabel = testLabel
        
        // classificationLabelが正しく更新されているかを確認
        XCTAssertEqual(model.classificationLabel, testLabel, "classificationLabelは設定された値と同じであるべき")
    }
    
    func testIsShowingSheetToggle() {
        let model = ImageModel()
        
        model.isShowingSheet = true
        
        // isShowingSheetが正しく更新されているかを確認
        XCTAssertTrue(model.isShowingSheet, "isShowingSheetはtrueであるべき")
    }
}
