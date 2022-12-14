//
//  Question.swift
//  Farmily
//
//  Created by κΉνμ on 2022/08/28.
//

import Foundation

struct QuestionWithPhoto: Decodable {
    let photo: String?
    let question: [Question]
}

struct Question: Decodable {
    let id: Int
    let familyId: Int
    let device: String?
    let question: String
    let weekNum: Int?
    let day: Int?
    let createdAt: String
    let weekId: Int?
    let answer: String?
    let userId: Int?
}

struct TodayQuestion: Decodable {
    let id: Int
    let question: String
    let isAnswered: Bool
}

struct TodayQuestionAnswer: Decodable {
    let id: Int
    let weekId: Int
    let answer: String
    let userId: Int
}

struct QuestionMax: Decodable {
    
    let max: Int
}


