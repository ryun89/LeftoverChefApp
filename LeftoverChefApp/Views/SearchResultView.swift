import SwiftUI

struct SearchResultView: View {
    @ObservedObject var recipeViewModel: RecipeViewModel
    
    // レシピで使用する食材の表示上限値
    private let DISPLAY_LIMIT = 5
    
    var body: some View {
        VStack {
            // 検索結果一覧をリストで表示する
            List(recipeViewModel.recipes, id: \.label) { recipe in
                HStack {
                    VStack(alignment: .leading){
                        Text(recipe.label)
                            .font(.headline)
                        Text("調理時間:\(recipe.totalTime)分")
                            .font(.body)
                        Text("使用する食材:")
                            .font(.subheadline)
                        ForEach(recipe.ingredientLines.prefix(DISPLAY_LIMIT), id: \.self) { ingredient in
                            Text(ingredient)
                                .font(.subheadline)
                        }
                        if recipe.ingredientLines.count > DISPLAY_LIMIT {
                            Text("...")
                                .font(.body)
                        }
                    }
                    Spacer()
                    if let imageUrl = URL(string: recipe.image) {
                        AsyncImage(url: imageUrl) { img in
                            img
                                .resizable()
                                .scaledToFit()
                                .frame(width: 150, height: 150)
                        } placeholder: {
                            ProgressView()
                        }
                    }
                }
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.orange)
        .edgesIgnoringSafeArea(.all)
    }
}
