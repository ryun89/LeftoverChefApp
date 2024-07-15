import SwiftUI

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
    @State var captureImage: UIImage? = nil
    @State private var isShowingSheet = false
    @ObservedObject var viewModel: ImagePickerViewModel
    @StateObject var imageModel = ImageModel()
    @StateObject var favoriteRecipeViewModel = FavoriteRecipeViewModel()
    // Activateかどうかを示すフラグ
    @State private var isActive = false
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                Spacer()
                // タイトル
                Text("あまりもん")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding(.top, 40)
                    .foregroundColor(.white)
                    .shadow(radius: 10) // タイトルを目立たせるための影を追加
                
                // 説明テキスト
                Text("~" + "冷蔵庫の余り物を有効活用" + "~")
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
                .sheet(isPresented: $isShowingSheet, onDismiss: {
                    // シートが閉じた際に条件を確認
                    if imageModel.capturedImage != nil && imageModel.classificationLabel != nil {
                        isActive = true
                    }
                }) {
                    ImagePickerView(viewModel: ImagePickerViewModel(model: imageModel))
                }
                
                // お気に入りレシピ画面へのナビゲーションボタン
                NavigationLink(destination: FavoriteRecipeView(favoriteRecipeViewModel: favoriteRecipeViewModel)) {
                    HStack {
                        Image(systemName: "star.fill")
                            .foregroundColor(.yellow)
                        Text("お気に入りのレシピ")
                            .font(.headline)
                            .foregroundColor(.orange)
                    }
                    .padding()
                    .background(Color.white)
                    .cornerRadius(8)
                    .shadow(radius: 2)
                }
                .padding()
                    
                    Spacer()
                    
                    NavigationLink(destination: ClassificationResultView(model: imageModel),
                                   isActive: $isActive) {
                    }
                }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color.orange)
            .edgesIgnoringSafeArea(.all)
            }
        }
    }
