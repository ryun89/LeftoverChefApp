import SwiftUI

struct ClassificationResultView: View {
    @Environment(\.modelContext) private var modelContext
    @ObservedObject var model: ImageModel
    @StateObject var recipeViewModel = RecipeViewModel()
    @ObservedObject var favoriteRecipeViewModel: FavoriteRecipeViewModel
    // Activateかどうかを示すフラグ
    @State private var isNavigationActive = false
    
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
                
                Text("分類結果:" + NSLocalizedString(label, comment: label))
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .padding()
            }
            
            // レシピを検索するボタン
            Button(action: {
                // レシピを検索する
                if let classificationLabel = model.classificationLabel {
                    recipeViewModel.SearchRecipes(searchQuery: classificationLabel)
                    isNavigationActive = true
                }
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
            NavigationLink(
                destination: SearchResultView(recipeViewModel: recipeViewModel, favoriteRecipeViewModel: favoriteRecipeViewModel),
                isActive: $isNavigationActive) {
                }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.orange)
        .edgesIgnoringSafeArea(.all)
        .navigationBarTitle("分類結果", displayMode: .inline)
        
    }
}
