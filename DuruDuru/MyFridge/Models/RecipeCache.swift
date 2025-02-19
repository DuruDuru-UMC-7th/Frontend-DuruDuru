//
//  RecipeCache.swift
//  DuruDuru
//
//  Created by 임효진 on 2/20/25.
//

import Foundation

struct RecipeCache {
    private static var cache = [String: [Recipe]]()
    private static let queue = DispatchQueue(label: "com.recipemanager.cachequeue", attributes: .concurrent)
    
    static func getRecipes(for ingredient: String) -> [Recipe]? {
        var result: [Recipe]?
        queue.sync {
            result = cache[ingredient]
        }
        return result
    }
    
    static func setRecipes(_ recipes: [Recipe], for ingredient: String) {
        queue.async(flags: .barrier) {
            cache[ingredient] = recipes
        }
    }
    
    static func clearCache() {
        queue.async(flags: .barrier) {
            cache.removeAll()
        }
    }
}
