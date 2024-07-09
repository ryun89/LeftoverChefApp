import SwiftUI

struct SearchResultView: View {
    @ObservedObject var recipeViewModel: RecipeViewModel
    
    // 選択されたレシピのリンク
    @State private var selectedRecipeLink: URL?
    
    // SafariViewを表示するかどうかのフラグ
    @State var isShowSafari = false
    
    // レシピで使用する食材の表示上限値
    private let DISPLAY_LIMIT = 5
    
    var body: some View {
        GeometryReader { geometry in
            VStack(alignment: .leading, spacing: 10) {
                // セーフエリアの上部のインセットを取得
                let topPadding = geometry.safeAreaInsets.top
                
                // 検索結果一覧をリストで表示する
                List(recipeViewModel.recipes, id: \.label) { recipe in
                    Button {
                        recipeViewModel.recipeLink = URL(string: recipe.url)
                        isShowSafari.toggle()
                        
                    } label: {
                        HStack {
                            VStack(alignment: .leading){
                                Text(recipe.label)
                                    .font(.title2)
                                if recipe.totalTime <= 0 {
                                    Text("調理時間:不明")
                                        .font(.body)
                                } else {
                                    Text("調理時間:\(recipe.totalTime)分")
                                        .font(.body)
                                }
                            }
                            Spacer()
                            if let imageUrl = URL(string: recipe.image) {
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
                .padding(.top, topPadding) // セーフエリアの上部のパディングを追加
                .background(Color.orange) // Listの背景色を設定
                .listStyle(PlainListStyle()) // Listのスタイルを設定
                
                .navigationBarTitle("レシピ検索結果", displayMode: .inline)
                .navigationBarTitleDisplayMode(.inline)
                .toolbarBackground(Color.orange, for: .navigationBar)
                
                .sheet(isPresented: $isShowSafari, content: {
                    SafariView(url: recipeViewModel.recipeLink!)
                        .ignoresSafeArea(edges: [.bottom])
                })
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color.orange)
            .edgesIgnoringSafeArea(.all)
        }
    }
}
