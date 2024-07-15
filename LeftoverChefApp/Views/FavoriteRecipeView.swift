import SwiftUI
import SwiftData
import Kingfisher

struct FavoriteRecipeView: View {
    @Environment(\.modelContext) private var modelContext
    @ObservedObject var favoriteRecipeViewModel: FavoriteRecipeViewModel
    @Query var favoriteRecipes: [FavoriteRecipeModel]
    
    // SafariViewを表示するかどうかのフラグ
    @State var isShowSafari = false
    
    var body: some View {
        GeometryReader { geometry in
            VStack(alignment: .leading, spacing: 10) {
                // セーフエリアの上部のインセットを取得
                let topPadding = geometry.safeAreaInsets.top
                
                // お気に入りレシピ一覧をリストで表示する
                List {
                    ForEach(favoriteRecipes, id: \.id) { recipe in
                        Button {
                            favoriteRecipeViewModel.recipeLink = URL(string: recipe.recipeURL)
                            isShowSafari.toggle()
                        } label: {
                            HStack {
                                VStack(alignment: .leading) {
                                    Text(recipe.recipeName)
                                        .font(.title2)
                                        .fontWeight(.bold) // フォントをボールド体に設定
                                    HStack {
                                        Image(systemName: "clock.fill") // アイコン追加
                                        if recipe.totalTime <= 0 {
                                            Text("調理時間:不明")
                                                .font(.body)
                                        } else {
                                            Text("調理時間:\(recipe.totalTime)分")
                                                .font(.body)
                                        }
                                    }
                                    HStack {
                                        Image(systemName: "flame.fill") // アイコン追加
                                        Text("カロリー: \(Int(recipe.calories)) kcal")
                                            .font(.body)
                                    }
                                    Text("ヘルスラベル:")
                                        .font(.subheadline)
                                    ForEach(recipe.healthLabels.prefix(3), id: \.self) { label in
                                        Text(NSLocalizedString(label, comment: label))
                                            .font(.subheadline)
                                            .background(Color.gray.opacity(0.2)) // ヘルスラベルの色分け
                                            .cornerRadius(4)
                                    }
                                }
                                Spacer()
                                if let imageUrl = URL(string: recipe.imageURL) {
                                    AsyncImage(url: imageUrl) { img in
                                        img
                                            .resizable()
                                            .scaledToFill()
                                            .frame(width: 150, height: 150)
                                            .clipped()
                                            .cornerRadius(10)
                                    } placeholder: {
                                        ProgressView()
                                    }
                                }
                            }
                        }
                    }
                    .onDelete { indexSet in
                        favoriteRecipeViewModel.deleteFavoriteRecipe(at: indexSet, context: modelContext)
                    }
                }
                .padding(.top, topPadding) // セーフエリアの上部のパディングを追加
                .background(Color.orange) // Listの背景色を設定
                .listStyle(PlainListStyle()) // Listのスタイルを設定
                
                .navigationBarTitle("レシピ検索結果", displayMode: .inline)
                .navigationBarTitleDisplayMode(.inline)
                .toolbarBackground(Color.orange, for: .navigationBar)
                
                .sheet(isPresented: $isShowSafari, content: {
                    SafariView(url: favoriteRecipeViewModel.recipeLink!)
                        .ignoresSafeArea(edges: [.bottom])
                })
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color.orange)
            .edgesIgnoringSafeArea(.all)
        }
        .navigationTitle("お気に入りのレシピ")
    }
}
