import XCTest
@testable import LeftoverChefApp

class ImagePickerViewModelTest: XCTestCase {
    
    var imagePickerViewModel: ImagePickerViewModel!
    var imageModel: ImageModel!
    
    override func setUp() {
        super.setUp()
        imageModel = ImageModel()
        imagePickerViewModel = ImagePickerViewModel(model: imageModel)
    }
    
    override func tearDown() {
        imagePickerViewModel = nil
        imageModel = nil
        super.tearDown()
    }
    
    func testImagePickerControllerDidFinishPickingMediaWithInfo() {
        
        let mockPicker = UIImagePickerController()
        let testImage = UIImage(systemName: "photo")!
        
        let info: [UIImagePickerController.InfoKey: Any] = [.originalImage: testImage]
        
        imagePickerViewModel.imagePickerController(mockPicker, didFinishPickingMediaWithInfo: info)
        
        XCTAssertNotNil(imageModel.capturedImage)
        XCTAssertEqual(imageModel.capturedImage, testImage)
    }
    
    func testImagePickerControllerDidCancel() {
        
        let mockPicker = UIImagePickerController()
        imageModel.isShowingSheet = true
        imagePickerViewModel.imagePickerControllerDidCancel(mockPicker)
        
        XCTAssertFalse(imageModel.isShowingSheet)
    }
    
    func testClassifyImage() {
        let testImage = UIImage(systemName: "photo")!
        let expectation = self.expectation(description: "Image Classified")
        
        imagePickerViewModel.classifyImage(image: testImage)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            XCTAssertNotNil(self.imageModel.classificationLabel) // nilが入ってテスト失敗（引数に渡す画像データが悪い？）
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 2, handler: nil)
    }
}
