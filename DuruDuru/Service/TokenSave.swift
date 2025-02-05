//
//  TokenSave.swift
//  DuruDuru
//
//  Created by 이은찬 on 2/5/25.
//

import Foundation

class TokenSave {
    static let shared = TokenSave()
    private init() {}
    
    var accessToken: String?
    
    var refreshToken: String?
}
