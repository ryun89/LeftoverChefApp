import SwiftUI
import SwiftData
import Combine

final class ItemDataSource {
    private let modelContainer: ModelContainer
    private let modelContext: ModelContext
    
    @MainActor
    static let shared = ItemDataSource()
    
    @MainActor
    private init() {
        self.modelContainer = try! ModelContainer(for: FavoriteRecipeModel.self)
        self.modelContext = modelContainer.mainContext
    }
    
    // お気に入りレシピを登録する
    func addFavoriteRecipe(targetRecipe: Recipe) {
        let newFavoriteRecipe = FavoriteRecipeModel(id: UUID(), recipeName: targetRecipe.label,
                                                    recipeURL: targetRecipe.url, imageURL: targetRecipe.image, calories: targetRecipe.calories,
                                                    totalTime: targetRecipe.totalTime, healthLabels: targetRecipe.healthLabels)
        modelContext.insert(newFavoriteRecipe)
        
        do {
            try modelContext.save()
        } catch {
            fatalError(error.localizedDescription)
        }
    }
    
    // お気に入りのレシピ一覧をフェッチする
    func fetchFavoriteRecipes() -> [FavoriteRecipeModel] {
        do {
            return try modelContext.fetch(FetchDescriptor<FavoriteRecipeModel>())
        } catch {
            fatalError(error.localizedDescription)
        }
    }
}
