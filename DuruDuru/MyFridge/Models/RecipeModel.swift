//
//  RecipeModel.swift
//  DuruDuru
//
//  Created by 임효진 on 1/13/25.
//

import UIKit

struct RecipeModel {
    
    let titleImage: String
    let recipeName: String
}

extension RecipeModel{
    static func dummy() ->[RecipeModel]{
        return[
            RecipeModel(titleImage: "https://i.pinimg.com/736x/14/2d/17/142d17d25981c516a8b07c9919da2459.jpg", recipeName: "레시피1"),
            RecipeModel(titleImage: "https://i.pinimg.com/736x/e4/cb/0e/e4cb0e0ed31a13ebc6ed18ecd56e001e.jpg", recipeName: "레시피2"),
            RecipeModel(titleImage: "https://i.pinimg.com/736x/3c/fc/24/3cfc24cc29f2a0e9d0a74a2fbdecfdb9.jpg", recipeName: "레시피3"),
            RecipeModel(titleImage: "https://i.pinimg.com/736x/bf/d9/e9/bfd9e9c6e57c2d75b5e156c4959ec7c5.jpg", recipeName: "레시피4"),
            RecipeModel(titleImage: "https://i.pinimg.com/736x/14/2d/17/142d17d25981c516a8b07c9919da2459.jpg", recipeName: "레시피5"),
        ]
    }
}
