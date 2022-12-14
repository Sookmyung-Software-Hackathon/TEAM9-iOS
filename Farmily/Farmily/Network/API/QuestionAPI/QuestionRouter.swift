//
//  QuestionRouter.swift
//  Farmily
//
//  Created by 김혜수 on 2022/08/27.
//

import Moya

struct FamilyQuestionAddRequest: Codable {
    let question: String
}

struct PostFamilyPhotoRequest {
    let file: UIImage
    let week: Int
}

struct PostTodayAnswer: Codable {
    let id: Int
    let answer: String
}


enum QuestionRouter {
    /// 오늘의 질문 조회 (DONE)
    case getTodayQuestion
    
    /// 오늘의 질문에 답변 (DONE)
    case postAnswerTodayQuestion(answer: PostTodayAnswer)
    
    /// 가족 질문 추가 (DONE)
    case postFamilyQuestionAdd(question: FamilyQuestionAddRequest)
    
    /// 마지막 주차 조회 (DONE)
    case getQuestionLastWeek
    
    /// 해당 주에 사진 추가 (DONE)
    case postPhoto(familyPhoto: PostFamilyPhotoRequest)
    
    /// 해당 주 질문 조회 (DONE)
    case getWeekQuestion(week: Int)
    
    /// 해당 주차 요일 답변 조회
    case getDayAnswer(week: Int, day: Int) 
}

extension QuestionRouter: BaseTargetType {
    var path: String {
        switch self {
        case .getTodayQuestion:
            return URLConstant.question
        case .postAnswerTodayQuestion:
            return URLConstant.question
        case .getQuestionLastWeek:
            return URLConstant.questionList
        case let .getWeekQuestion(week):
            return URLConstant.questionList + "/\(week)"
        case .postFamilyQuestionAdd:
            return URLConstant.questionFamily
        case let .postPhoto(familyPhoto):
            return URLConstant.questionList + "/\(familyPhoto.week)"
        case let .getDayAnswer(week, day):
            return URLConstant.questionList + "/\(week)/\(day)"

        }
    }
    
    var method: Method {
        switch self {
        case .getQuestionLastWeek, .getTodayQuestion, .getDayAnswer:
            return .get
        case .getWeekQuestion:
            return .get
        case .postFamilyQuestionAdd, .postAnswerTodayQuestion:
            return .post
        case .postPhoto:
            return .post
        }
    }
    
    var task: Task {
        switch self {
        case .getQuestionLastWeek, .getWeekQuestion, .getTodayQuestion, .getDayAnswer:
            return .requestPlain
        case let .postFamilyQuestionAdd(question):
            return .requestParameters(parameters: question.toDictionary,
                                      encoding: JSONEncoding.default)
        case let .postPhoto(familyPhoto):
            return .uploadMultipart(createMultipartFormDataList(familyPhoto))
        case let .postAnswerTodayQuestion(answer):
            return .requestParameters(parameters: answer.toDictionary, encoding: JSONEncoding.default)
        default:
            return .requestPlain
        }
    }
    
  
}

extension QuestionRouter {
    
    func createMultipartFormDataList(_ postFamilyPhoto: PostFamilyPhotoRequest) -> [MultipartFormData] {
            var list: [MultipartFormData] = []
            list.append(MultipartFormData(
                provider: .data(postFamilyPhoto.file.pngData() ?? Data()),
                name: "file",
                fileName: "defautlt.png",
                mimeType: "image/png"))
            return list
        }
}
