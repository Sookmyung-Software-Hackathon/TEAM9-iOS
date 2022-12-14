//
//  Family.swift
//  Farmily
//
//  Created by κΉνμ on 2022/08/28.
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
