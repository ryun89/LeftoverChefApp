import Foundation

// レシピデータ
struct Recipe: Codable, Equatable {
    let label: String
    let url: String
    let image: String
    let calories: Double
    let totalTime: Int
    let healthLabels: [String]
    
    // Equatable準拠のために==演算子をオーバーロード
    static func == (lhs: Recipe, rhs: Recipe) -> Bool {
        return lhs.label == rhs.label && lhs.url == rhs.url && lhs.image == rhs.image && lhs.calories == rhs.calories && lhs.totalTime == rhs.totalTime && lhs.healthLabels == rhs.healthLabels
    }
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
    let app_id = ""
    let app_key = ""
    
    func fetchRecipes(query: String, completion: @escaping ([Recipe]) -> Void) {
        guard let url = URL(string: "\(baseURL)?q=\(query)&app_id=\(app_id)&app_key=\(app_key)&from=0&to=50") else {
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
