import SwiftUI
import SwiftData
import Combine

class FavoriteRecipeViewModel: ObservableObject {
    @Query var savedFavoriteRecipes: [FavoriteRecipeModel]
    @Environment(\.modelContext)  var context
    
    // クリックされたWebページのリンク
    var recipeLink: URL?
    
    // お気に入りレシピを登録する
    func addFavoriteRecipe(targetRecipe: Recipe) {
        let newFavoriteRecipe = FavoriteRecipeModel(id: UUID(), recipeName: targetRecipe.label, 
                                                    recipeURL: targetRecipe.url, imageURL: targetRecipe.image, calories: targetRecipe.calories, 
                                                    totalTime: targetRecipe.totalTime, healthLabels: targetRecipe.healthLabels)
        context.insert(newFavoriteRecipe)
    }
    
    // お気に入りレシピを削除する
    func removeFavoriterecipes(targetRecipe: Recipe) {
        let targetFavoriteRecipe = FavoriteRecipeModel(id: UUID(), recipeName: targetRecipe.label,
                                                       recipeURL: targetRecipe.url, imageURL: targetRecipe.image, calories: targetRecipe.calories, 
                                                       totalTime: targetRecipe.totalTime, healthLabels: targetRecipe.healthLabels)
        context.delete(targetFavoriteRecipe)
    }
}
