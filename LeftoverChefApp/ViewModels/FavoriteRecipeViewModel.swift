import SwiftUI
import SwiftData
import Combine

class FavoriteRecipeViewModel: ObservableObject {
    @Published var favoriteRecipes: [FavoriteRecipeModel] = []
    @Environment(\.modelContext) private var context
    
    init() {
     fetchFavoriteRecipes()
    }
    
    // お気に入り登録されたレシピを全て取得する
    func fetchFavoriteRecipes() {
        @Query var savedFavoriteRecipes: [FavoriteRecipeModel]
        self.favoriteRecipes = savedFavoriteRecipes
    }
    
    // お気に入りレシピを登録する
    func addFavoriteRecipe(newFavoriteRecipe: FavoriteRecipeModel) {
        context.insert(newFavoriteRecipe)
    }
    
    // お気に入りレシピを削除する
    func removeFavoriterecipes(targetFavoriteRecipe: FavoriteRecipeModel) {
        context.delete(targetFavoriteRecipe)
    }
}
