import SwiftUI

class RecipeViewModel: ObservableObject {
    @Published var recipes: [Recipe] = []
    @Published var searchQuery = ""
    private let api = RecipeAPI()
    
    // クリックされたWebページのリンク
    var recipeLink: URL?
    
    // レシピを検索するメソッド
    func SearchRecipes(searchQuery: String) {
        api.fetchRecipes(query: searchQuery) { recipes in
            self.recipes = recipes
        }
    }
}
