//
//  Question.swift
//  Farmily
//
//  Created by 김혜수 on 2022/08/28.
//

import Foundation

struct Question: Decodable {
    let id: Int
    let familyId: Int
    let device: String?
    let question: String
    let weekNum: Int?
    let day: Int?
    let createdAt: String
    
}

struct QuestionMax: Decodable {
    
    let max: Int
}
