//
//  LeftoverChefAppApp.swift
//  LeftoverChefApp
//
//  Created by 八久響 on 2024/07/06.
//

import SwiftUI

@main
struct LeftoverChefAppApp: App {
    
    var body: some Scene {
        WindowGroup {
            let imageModel = ImageModel()
            ContentView(viewModel: ImagePickerViewModel(model: imageModel))
        }
        .modelContainer(for: [FavoriteRecipeModel.self])
    }
}
