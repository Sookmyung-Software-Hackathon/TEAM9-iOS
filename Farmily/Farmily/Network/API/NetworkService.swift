//
//  NetworkService.swift
//  Farmily
//
//  Created by κΉνμ on 2022/08/28.
//

import Foundation

final class NetworkService {
    static let shared = NetworkService()

    private init() { }
    
    let family: FamilyService = DefaultFamilyService()
    let question: QuestionService = DefaultQuestionService()
    let photo: PhotoService = DefaultPhotoService()
}
