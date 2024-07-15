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
    func addFavoriteRecipe(targetRecipe: Recipe) {
    let newFavoriteRecipe = FavoriteRecipeModel(id: UUID(), recipeName: targetRecipe.label, 
                                                recipeURL: targetRecipe.url, imageURL: targetRecipe.image)
        context.insert(newFavoriteRecipe)
    }
    
    // お気に入りレシピを削除する
    func removeFavoriterecipes(targetRecipe: Recipe) {
        let targetFavoriteRecipe = FavoriteRecipeModel(id: UUID(), recipeName: targetRecipe.label,
                                                       recipeURL: targetRecipe.url, imageURL: targetRecipe.image)
        context.delete(targetFavoriteRecipe)
    }
}
