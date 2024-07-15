import Foundation
import SwiftData

// お気に入りレシピテーブル
@Model
final class FavoriteRecipeModel {
    @Attribute(.unique) var id: UUID
    var recipeName: String
    var recipeURL: String
    var imageURL: String
    var calories: Double
    var totalTime: Int
    var healthLabels: [String]
    
    init(id: UUID, recipeName: String, recipeURL: String, imageURL: String, calories: Double, totalTime: Int, healthLabels: [String]) {
        self.id = id
        self.recipeName = recipeName
        self.recipeURL = recipeURL
        self.imageURL = imageURL
        self.calories = calories
        self.totalTime = totalTime
        self.healthLabels = healthLabels
    }
}
