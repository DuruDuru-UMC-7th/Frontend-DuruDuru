//
//  RecipeModel.swift
//  DuruDuru
//
//  Created by 임효진 on 1/13/25.
//

import UIKit

struct IngredientModel {
    
    let name: String
    let recipes: [RecipeModel]
}

struct RecipeModel {
    
    let titleImage: String
    let recipeName: String
}

extension IngredientModel{
    static func dummy() ->[IngredientModel]{
        return[
            IngredientModel(name:"우유", recipes: [
                RecipeModel(titleImage: "https://i.pinimg.com/736x/14/2d/17/142d17d25981c516a8b07c9919da2459.jpg", recipeName: "우유 레시피1"),
                RecipeModel(titleImage: "https://i.pinimg.com/474x/a0/e1/f7/a0e1f7e365bb3ccda6eb0f7e930bc6e2.jpg", recipeName: "우유 레시피2"),
                RecipeModel(titleImage: "https://i.pinimg.com/474x/fd/ff/d3/fdffd36cf60633860d748300f94d4239.jpg", recipeName: "우유 레시피3")
            ]),
            IngredientModel(name:"계란", recipes: [
                RecipeModel(titleImage: "https://i.pinimg.com/736x/e4/cb/0e/e4cb0e0ed31a13ebc6ed18ecd56e001e.jpg", recipeName: "계란 레시피1"),
                RecipeModel(titleImage: "https://i.pinimg.com/736x/bf/26/f3/bf26f3425113e774d3aaa2a45776df5d.jpg", recipeName: "게란 레시피2"),
                RecipeModel(titleImage: "https://i.pinimg.com/736x/1a/12/0e/1a120e77cd19cbc1132d8b9fcf06546e.jpg", recipeName: "계란 레시피3")
            ]),
            IngredientModel(name:"사과", recipes: [
                RecipeModel(titleImage: "https://i.pinimg.com/736x/3c/fc/24/3cfc24cc29f2a0e9d0a74a2fbdecfdb9.jpg", recipeName: "사과 레시피1"),
                RecipeModel(titleImage: "https://i.pinimg.com/736x/46/6f/c1/466fc1aa9cc06febf5bbac39d12699f3.jpg", recipeName: "사과 레시피2"),
                RecipeModel(titleImage: "https://i.pinimg.com/736x/3c/fc/24/3cfc24cc29f2a0e9d0a74a2fbdecfdb9.jpg", recipeName: "사과 레시피3")
            ]),
            IngredientModel(name:"돼지고기", recipes: [
                RecipeModel(titleImage: "https://i.pinimg.com/736x/bf/d9/e9/bfd9e9c6e57c2d75b5e156c4959ec7c5.jpg", recipeName: "돼지고기 레시피1"),
                RecipeModel(titleImage: "https://i.pinimg.com/474x/db/5c/d7/db5cd739b23b3029aaddeebd565c4b00.jpg", recipeName: "돼지고기 레시피2"),
                RecipeModel(titleImage: "https://i.pinimg.com/736x/bf/d9/e9/bfd9e9c6e57c2d75b5e156c4959ec7c5.jpg", recipeName: "돼지고기 레시피3")
            ]),
            IngredientModel(name:"두부", recipes: [
                RecipeModel(titleImage: "https://i.pinimg.com/736x/14/2d/17/142d17d25981c516a8b07c9919da2459.jpg", recipeName: "두부 레시피1"),
                RecipeModel(titleImage: "https://i.pinimg.com/474x/c4/e6/20/c4e62081d3ec4df10dd39693a2bece4b.jpg", recipeName: "두부 레시피2"),
                RecipeModel(titleImage: "https://i.pinimg.com/474x/e9/e5/8f/e9e58f523baa5854652c57385da099d6.jpg", recipeName: "두부 레시피3")
            ]),
        ]
    }
}
