import SwiftUI
import SwiftData
import Combine

class FavoriteRecipeViewModel: ObservableObject {
    @ObservationIgnored
    private let dataSource: ItemDataSource
    
    @Published var favoriteRecipes: [FavoriteRecipeModel] = []
    
    // クリックされたWebページのリンク
    var recipeLink: URL?
    
    init(dataSource: ItemDataSource = ItemDataSource.shared) {
        self.dataSource = dataSource
        favoriteRecipes = dataSource.fetchFavoriteRecipes()
    }
    
    // お気に入りレシピを登録する
    func addFavoriteRecipe(targetRecipe: Recipe) {
        dataSource.addFavoriteRecipe(targetRecipe: targetRecipe)
        print("お気に入り登録完了")
    }
    
    // データベースからお気に入りレシピを削除する関数
    func deleteFavoriteRecipe(at offsets: IndexSet, context: ModelContext) {
        for index in offsets {
            print("favoriteRecipes_index: \(index)")
            let recipe = favoriteRecipes[index]
            context.delete(recipe)
            favoriteRecipes.remove(at: index)
        }
        do {
            try context.save()
        } catch {
            print("Failed to save context after deletion: \(error)")
        }
    }
}
