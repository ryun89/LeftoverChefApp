import Foundation
import SwiftData

// お気に入りレシピテーブル
@Model
final class FavoriteRecipeModel {
    @Attribute(.unique) var id: UUID
    var recipeName: String
    var recipeURL: String
    var imageURL: String
    
    init(id: UUID, recipeName: String, recipeURL: String, imageURL: String) {
        self.id = id
        self.recipeName = recipeName
        self.recipeURL = recipeURL
        self.imageURL = imageURL
    }
}
