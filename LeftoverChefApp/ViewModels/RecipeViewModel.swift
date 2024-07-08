import SwiftUI

class RecipeViewModel: ObservableObject {
    @Published var recipes: [Recipe] = []
    @Published var searchQuery = ""
    private let api = RecipeAPI()
    
    // レシピを検索するメソッド
    func SearchRecipes(searchQuery: String) {
        api.fetchRecipes(query: searchQuery) { recipes in
            self.recipes = recipes
        }
    }
}
