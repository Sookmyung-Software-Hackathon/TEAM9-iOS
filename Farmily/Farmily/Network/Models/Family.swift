//
//  Family.swift
//  Farmily
//
//  Created by 김혜수 on 2022/08/28.
//

import Foundation

struct Family: Decodable {
    let id: Int
    let code: String
    let order: Int
}

struct FamilyJoin: Decodable {
    
    let user: User
    let accessToken: String
}
