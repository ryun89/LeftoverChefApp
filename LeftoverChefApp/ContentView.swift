import SwiftUI

struct ContentView: View {
    @State var captureImage: UIImage? = nil
    @State private var isShowingSheet = false
    @ObservedObject var viewModel: ImagePickerViewModel
    
    var body: some View {
        VStack(spacing: 20) {
            // タイトル
            Text("あまりもん")
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding(.top, 40)
                .foregroundColor(.white)
                .shadow(radius: 10) // タイトルを目立たせるための影を追加
            
            // 説明テキスト
            Text("~" + "冷蔵庫の余り物を有効活用!" + "~")
                .font(.title2)
                .fontWeight(.medium)
                .foregroundColor(.white)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 20)
                .shadow(radius: 5) // 説明テキストにも影を追加
            
            Spacer()
            
            // カメラを起動するボタン
            Button(action: {
                // カメラが使用可能なら撮影画面を表示
                if UIImagePickerController.isSourceTypeAvailable(.camera) {
                    isShowingSheet.toggle()
                }
            }) {
                HStack {
                    Image(systemName: "camera.fill") // アイコンを追加
                    Text("カメラを起動する")
                        .font(.title2)
                        .fontWeight(.semibold)
                }
                .padding()
                .frame(maxWidth: .infinity)
                .background(Color.white)
                .foregroundColor(.orange)
                .cornerRadius(10)
                .shadow(radius: 5)
                .padding(.horizontal, 40)
            }
            .sheet(isPresented: $isShowingSheet) {
                // UIImagePickerControllerを表示する
                ImagePickerView(viewModel: viewModel)
            }
            
            Spacer()
        }
        .background(Color.orange.edgesIgnoringSafeArea(.all))
    }
}
