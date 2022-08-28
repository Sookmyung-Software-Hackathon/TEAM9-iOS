//
//  FamilyPhoto.swift
//  Farmily
//
//  Created by 김혜수 on 2022/08/28.
//

import Foundation

struct FamilyPhoto: Decodable {
    
    let id: Int
    let url: String
    let week: Int
    let familyId: Int
    let createdAt: String
    let device: String?
}
