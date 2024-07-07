import SwiftUI

struct ClassificationResultView: View {
    @ObservedObject var model: ImageModel
    
    var body: some View {
        VStack {
            if let image = model.capturedImage, let label = model.classificationLabel {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 400, height: 400)
                    .cornerRadius(10)
                    .shadow(radius: 5)
                    .padding()
                
                Text("分類結果: \(label)")
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .padding()
            }
            
            // レシピを検索するボタン
            Button(action: {
                // カメラが使用可能なら撮影画面を表示
            }) {
                HStack {
                    // アイコンを追加
                    Image(systemName: "magnifyingglass.circle.fill")
                        .font(.title)
                    Text("レシピを検索する")
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
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.orange)
        .edgesIgnoringSafeArea(.all)
        .navigationBarTitle("分類結果", displayMode: .inline)
        
    }
}
