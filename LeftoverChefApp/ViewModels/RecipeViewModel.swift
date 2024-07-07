import SwiftUI

class RecipeViewModel: ObservableObject {
    @State var recipes: [Recipe] = []
    private let api = RecipeAPI()
    
    @Published var model: ImageModel
    init(model: ImageModel) {
        self.model = model
    }
    
    // レシピを検索するメソッド
    func SearchRecipes(searchQuery: String) {
        api.fetchRecipes(query: searchQuery) { recipes in
            self.recipes = recipes
        }
    }
}
