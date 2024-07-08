import Foundation

// レシピデータ
struct Recipe: Codable {
    let label: String
    let url: String
    let image: String
    let ingredientLines: [String]
    let totalTime: Int
}

struct Hit: Codable {
    let recipe: Recipe
}

struct RecipeResponce: Codable {
    let hits: [Hit]
}

// レシピAPI
class RecipeAPI {
    let baseURL = "https://api.edamam.com/search"
    let app_id = "8d94ea6f"
    let app_key = "e1811877cb09b986d22bb6c29a81da70"
    
    func fetchRecipes(query: String, completion: @escaping ([Recipe]) -> Void) {
        guard let url = URL(string: "\(baseURL)?q=\(query)&app_id=\(app_id)&app_key=\(app_key)&from=0&to=10") else {
            return
        }
        // URL出力
        print(url)
        
        // リクエストURLからダウンロード
        URLSession.shared.dataTask(with: url) { data, responce, error in
            if let data = data {
                do {
                    let result = try! JSONDecoder().decode(RecipeResponce.self, from: data)
                    let recipes = result.hits.map { $0.recipe }
                    DispatchQueue.main.async {
                        completion(recipes)
                    }
                } catch {
                    print(error)
                    completion([])
                }
            }
        }.resume()
    }
}
