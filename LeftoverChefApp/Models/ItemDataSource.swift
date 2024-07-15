import SwiftUI
import SwiftData
import Combine
import Kingfisher

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
    func createFavoriteRecipe(targetRecipe: Recipe) -> FavoriteRecipeModel {
        let newFavoriteRecipe = FavoriteRecipeModel(id: UUID(), recipeName: targetRecipe.label,
                                                    recipeURL: targetRecipe.url, imageURL: targetRecipe.image, calories: targetRecipe.calories,
                                                    totalTime: targetRecipe.totalTime, healthLabels: targetRecipe.healthLabels)
        modelContext.insert(newFavoriteRecipe)
        
        do {
            try modelContext.save()
        } catch {
            fatalError(error.localizedDescription)
        }
        
        // 画像をキャッシュに保存する
        if let url = URL(string: targetRecipe.image) {
            cacheImage(for: url)
        }
        
        return newFavoriteRecipe
    }
    
    // 画像をキャッシュに保存する
    func cacheImage(for url: URL) {
        let resource = KF.ImageResource(downloadURL: url)
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let data = data, let image = UIImage(data: data) {
                KingfisherManager.shared.cache.store(image, forKey: resource.cacheKey)
            }
        }.resume()
    }
    
    
    // お気に入りレシピを削除する
    func deleteFavoriteRecipe(targetFavoriteRecipe: FavoriteRecipeModel) {
        modelContext.delete(targetFavoriteRecipe)
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
